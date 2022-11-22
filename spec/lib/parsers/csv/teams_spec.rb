# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::Csv::Teams do
  describe '.call' do
    let(:csv) do
      CSV.foreach('spec/fixtures/files/two_matches.csv', headers: true)
    end

    subject { described_class.call(csv) }

    context 'when any of the teams exists' do
      it 'creates all teams' do
        expect { subject }.to change(Team, :count).by(3)
      end
    end

    context 'when at least one of the teams exists' do
      before { create(:team, name: 'Benfica') }

      it 'creates only needed teams' do
        expect { subject }.to change(Team, :count).by(2)
      end
    end
  end
end
