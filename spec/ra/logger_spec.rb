# frozen_string_literal: true

require 'spec_helper'

describe Ra::Logger do
  subject(:logger) { build(:logger, stream:) }

  let(:stream) { instance_double(IO) }

  describe '#log' do
    it 'proxies to stream' do
      allow(stream).to receive(:puts)
      logger.log('Hello!')
      expect(stream).to have_received(:puts).with('Hello!')
    end
  end
end
