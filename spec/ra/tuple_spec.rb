# frozen_string_literal: true

require 'spec_helper'

describe Ra::Tuple do
  context 'when a tuple is a vector (w = 0)' do
    let(:tuple) { build(:vector, x: 4, y: 5, z: 6) }

    it { expect(tuple[0]).to eq(4) }
    it { expect(tuple[1]).to eq(5) }
    it { expect(tuple[2]).to eq(6) }
    it { expect(tuple[3]).to eq(described_class::VECTOR) }
  end

  context 'when a tuple is a point (w = 1)' do
    let(:tuple) { build(:point, x: 4, y: 5, z: 6) }

    it { expect(tuple[0]).to eq(4) }
    it { expect(tuple[1]).to eq(5) }
    it { expect(tuple[2]).to eq(6) }
    it { expect(tuple[3]).to eq(described_class::POINT) }
  end
end
