# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do
  include ApiHelpers

  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }

  describe 'POST create' do
    subject(:request!) { post api_v1_importers_path, params: params, headers: authenticate!(user) }
    let(:params) { { importer: { csv: fixture_file_upload('two_matches.csv') } } }

    it 'creates a Importer and enqueue job' do
      expect { request! }.to change(Importer, :count).by(1)
        .and have_enqueued_job(ImporterCsvJob).once
    end
  end
end
