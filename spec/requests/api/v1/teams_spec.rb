# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do
  include ApiHelpers

  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }

  describe 'POST create' do
    subject(:request!) { post api_v1_teams_path, params: params, headers: authenticate!(user) }

    context 'when creating a team' do
      context 'with right attributes' do
        let(:team_name) { Faker::Sports::Football.team }
        let(:team_description) { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
        let(:params) {{ team: { name: team_name, description: team_description }}}

        it 'returns team attributes', :aggregate_failures do
          expect { request! }.to change(Team, :count).by(1)

          expect(response).to have_http_status(:ok)
          expect(json).to include_json(
            {
              data: {
                type: 'team',
                attributes: {
                  name: team_name,
                  description: team_description
                }
              }
            }
          )
        end
      end

      context 'with missing attributes' do
        let(:params) {{ team: { name: 'Ibis', description: '' }}}

        it 'returns error', :aggregate_failures do
          request!

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json).to include_json({ errors: { description: ["can't be blank"] } })
        end
      end
    end
  end

  describe 'PATCH update' do
    subject(:request!) { patch api_v1_team_path(team), params: params, headers: authenticate!(user) }

    let(:team) { create(:team, name: 'Ibis', description: 'Ibis Futebol') }

    context 'with right attributes' do
      let(:params) { { team: { name: 'Tabajara' } } }

      it 'returns team attributes', :aggregate_failures do
        expect { request! }.to change { team.reload.name }.from('Ibis').to('Tabajara')

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with missing attributes' do
      let(:params) { { team: { description: '' } } }

      it 'returns error', :aggregate_failures do
        request!

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include_json({ errors: { description: ["can't be blank"] }})
      end
    end
  end

  describe 'DELETE destroy' do
    subject(:request!) { delete api_v1_team_path(team_id), headers: authenticate!(user) }

    let!(:team) { create(:team) }

    context 'with existent team' do
      let(:team_id) { team.id }

      it 'removes properly', :aggregate_failures do
        expect { request! }.to change(Team, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with not existent team' do
      let(:team_id) { 9999 }

      it 'returns error response' do
        expect { request! }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET show' do
    subject(:request!) { get api_v1_team_path(team_id), headers: authenticate!(user) }
    let(:team_name) { Faker::Sports::Football.team }
    let(:team_description) { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    let(:team) { create(:team, name: team_name, description: team_description) }
    let(:team_id) { team.id }

    context 'with a valid id' do
      before { request! }
      it 'returns team serialized' do
        expect(json).to include_json(
          {
            data: {
              type: 'team',
              attributes: {
                name: team_name,
                description: team_description
              }
            }
          }
        )
      end
    end

    context 'without a valid id' do
      let(:team_id) { 'aaa' }

      it 'returns error response' do
        expect { request! }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET index' do
    subject(:request!) { get api_v1_teams_path, headers: authenticate!(user) }
    let!(:team_one) {create(:team) }
    let!(:team_two) {create(:team) }
    before { request! }

    it 'returns all teams' do
      expect(json).to include_json(
        {
          data: [team_one, team_two].map do |team|
            {
              type: 'team',
              attributes: {
                name: team.name,
                description: team.description
              }
            }
          end
        }
      )
    end
  end
end
