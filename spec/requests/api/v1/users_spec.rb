# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  include ApiHelpers

  let(:json) { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe 'Creating a user' do
    subject(:request!) { post api_v1_users_path, params: params, headers: authenticate!(user) }

    context 'when creating a user' do
      context 'with right attributes' do
        let(:params) { {
          user: { name: 'Jane Doe', email: 'jdoe@fbi.com', password: '123bar' }
        } }

        it 'returns user attributes', :aggregate_failures do
          expect { request! }.to change(User, :count).by(1)

          expect(response).to be_successful
          expect(json['data']['type']).to eq('user')
          expect(json['data']['attributes']['name']).to eq('Jane Doe')
          expect(json['data']['attributes']['email']).to eq('jdoe@fbi.com')
        end
      end

      context 'with missing attributes' do
        let(:params) { {
          user: { name: 'Jane Doe', email: 'jdoe@fbi.com', password: '' }
        } }

        it 'returns error', :aggregate_failures do
          request!

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json['errors']['password']).to include("can't be blank")
        end
      end
    end
  end

  describe 'Updating an user' do
    subject(:request!) { patch api_v1_user_path(user), params: params, headers: authenticate!(user) }

    let(:user) { create(:user, name: 'Vinicius Lima', email: 'vini@example.com') }

    context 'with right attributes' do
      let(:params) { { user: { name: 'Vini Lima' } } }

      it 'returns user attributes', :aggregate_failures do
        expect { request! }.to change { user.reload.name }.from('Vinicius Lima').to('Vini Lima')

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with missing attributes' do
      let(:params) { { user: { email: '' } } }

      it 'returns error', :aggregate_failures do
        request!

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']['email']).to include("can't be blank")
      end
    end
  end

  describe 'Removing a user' do
    subject(:request!) { delete api_v1_user_path(user_id), headers: authenticate!(user) }

    let!(:user) { create(:user) }

    context 'with existent user' do
      let(:user_id) { user.id }

      it 'removes properly', :aggregate_failures do
        expect { request! }.to change(User, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with not existent user' do
      let(:user_id) { 9999 }

      it 'returns error response' do
        expect { request! }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Showing a user' do
    let!(:another_user) { create(:user) }
    let(:user_id) { another_user.id }

    context 'when not authenticated' do
      it 'returns not authorized' do
        get api_v1_user_path(user_id), headers: authenticate!(User.new(id: 1))

        expect(response).to have_http_status(:unauthorized)
        expect(json).to include_json(error: 'User not found')
      end
    end

    context 'when authenticated' do
      subject(:request!) { get api_v1_user_path(user_id), headers: authenticate!(user) }

      context 'with existent user id' do
        it 'returns the user' do
          request!

          expect(response).to be_successful
          expect(json['data']['type']).to eq('user')
          expect(json['data']['attributes']['name']).to eq(another_user.name)
          expect(json['data']['attributes']['email']).to eq(another_user.email)
        end
      end
    end
  end
end
