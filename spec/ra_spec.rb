# frozen_string_literal: true

RSpec.describe Ra do
  it { expect(Ra::VERSION).not_to be_nil }

  describe '.logger' do
    subject(:logger) { described_class.logger }

    it { expect(logger).to be_instance_of(Ra::Logger) }
  end
end
