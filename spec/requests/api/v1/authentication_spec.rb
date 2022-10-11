# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :request do
  let(:json) { JSON.parse(response.body) }
  let!(:user) { create(:user, email: 'jdoe@clicksign.com', password: 'foobar123') }

  describe 'Authenticating a user' do
    subject(:request!) { post api_v1_sign_in_path, params: { user:
      { email: email, password: password } }  }
    let(:email) { 'jdoe@clicksign.com' }
    let(:password) { 'foobar123' }

    context 'when passing a existent user' do
      context 'with right password' do
        it 'returns the token', :aggregate_failures do
          request!

          expect(response).to be_successful
          expect(json['token']).not_to be_empty
        end
      end

      context 'with wrong password' do
        let(:password) { 'abcd123' }

        it 'returns error', :aggregate_failures do
          request!

          expect(response).to have_http_status(:unauthorized)
          expect(json).to include_json(error: 'Password is not right')
        end
      end
    end

    context 'when passing a inexistent user' do
      let(:email) { 'janedoe@clicksign.com' }

      it 'returns error', :aggregate_failures do
        request!

        expect(response).to have_http_status(:unauthorized)
        expect(json).to include_json(error: 'User doesnt exists')
      end
    end
  end
end
