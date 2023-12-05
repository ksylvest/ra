# frozen_string_literal: true

require 'spec_helper'

describe Ra::Quadratic do
  describe '.solve' do
    subject(:solve) { described_class.solve(a:, b:, c:) }

    let(:a) { 2 }
    let(:b) { 5 }
    let(:c) { 3 }

    it { expect(solve).to eql([-1.5, -1.0]) }
  end
end
