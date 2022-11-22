# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchChannel, type: :channel do
  context 'when connection is valid' do
    before do
      subscribe match_id: 1
    end

    it 'successfully subscribes' do
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from('match_channel_1')
    end

    it 'successfully unsubscribed' do
      perform :unsubscribed
      expect(subscription).not_to have_streams
    end
  end

  context 'when connection is not valid' do
    before do
      subscribe match: 1
    end

    it 'rejects subscription' do
      expect(subscription).to be_rejected
    end
  end
end
