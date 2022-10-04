# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'Creating a user' do
    subject(:request!) { post api_v1_users_path, params: params }

    context 'when creating a user' do
      context 'with right attributes' do
        let(:params) { {
          user: { name: 'Jane Doe', email: 'jdoe@fbi.com', password: '123bar' }
        } }

        it 'returns user attributes', :aggregate_failures do
          expect { request! }.to change(User, :count).by(1)

          expect(response).to have_http_status(:ok)
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
    subject(:request!) { patch api_v1_user_path(user), params: params }

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
    subject(:request!) { delete api_v1_user_path(user_id) }

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
end
