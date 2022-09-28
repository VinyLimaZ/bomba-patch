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
end
