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

  describe '.cross' do
    subject(:cross) { described_class.cross(source, target) }

    let(:source) { build(:vector, x: 1, y: 2, z: 3) }
    let(:target) { build(:vector, x: 2, y: 3, z: 4) }

    it { expect(cross).to eq(build(:vector, x: -1, y: 2, z: -1)) }
  end

  describe '.reflect' do
    subject(:reflect) { described_class.reflect(vector, normal) }

    let(:vector) { build(:vector, x: 1, y: -1, z: 0) }
    let(:normal) { build(:vector, x: 0, y: 1, z: 0) }

    it { expect(reflect).to eq(build(:vector, x: 1, y: 1, z: 0)) }
  end
end
