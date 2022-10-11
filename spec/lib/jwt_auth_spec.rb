# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtAuth do
  include ActiveSupport::Testing::TimeHelpers

  describe '.encode' do
    context 'when passing an hash' do
      it 'encodes the hash' do
        expect(described_class.encode(anyparam: 'anystring')).not_to be_nil
      end
    end

    context 'when passing other types' do
      it 'raises an error', :aggregate_failures do
        expect { described_class.encode(1) }.to raise_error(TypeError)
        expect { described_class.encode([]) }.to raise_error(TypeError)
        expect { described_class.encode(true) }.to raise_error(TypeError)
        expect { described_class.encode('1') }.to raise_error(TypeError)
      end
    end
  end

  describe '.decode' do
    context 'when passing a valid hash' do
      let(:token) { described_class.encode(hello: 'world') }

      it 'decodes the hash' do
        expect(described_class.decode(token)).to include('hello' => 'world')
      end
    end

    context 'when passing a expired token' do
      let(:token) do
        travel_to(31.days.ago) do
          described_class.encode(hello: 'world')
        end
      end

      it 'doesnt decode' do
        expect { described_class.decode(token) }.to raise_error(JWT::ExpiredSignature)
      end
    end
  end
end
