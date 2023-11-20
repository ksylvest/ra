# frozen_string_literal: true

require 'spec_helper'

describe Ra::Transform do
  subject(:transform) { build(:transform) }

  it { expect(transform).to be_a(Matrix) }

  describe '::IDENTITY' do
    subject(:identity) { described_class::IDENTITY }

    let(:result) do
      described_class[
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
      ]
    end

    it { expect(identity).to eq(result) }
  end

  describe '.translate' do
    subject(:translate) { described_class.translate(1, 2, 3) }

    let(:result) do
      described_class[
        [1, 0, 0, 1],
        [0, 1, 0, 2],
        [0, 0, 1, 3],
        [0, 0, 0, 1],
      ]
    end

    it { expect(translate).to eq(result) }
    it { expect(translate * Vector[1, 2, 3, 1]).to eq(Vector[2, 4, 6, 1]) }
  end

  describe '.scale' do
    subject(:scale) { described_class.scale(1, 2, 3) }

    let(:result) do
      described_class[
        [1, 0, 0, 0],
        [0, 2, 0, 0],
        [0, 0, 3, 0],
        [0, 0, 0, 1],
      ]
    end

    it { expect(scale).to eq(result) }
    it { expect(scale * Vector[1, 2, 3, 0]).to eq(Vector[1, 4, 9, 0]) }
  end

  describe '.rotate_x' do
    subject(:rotate_x) { described_class.rotate_x(rotation) }

    let(:rotation) { Math::PI / 4 }

    let(:result) do
      described_class[
        [1, 0, 0, 0],
        [0, +Math.cos(rotation), -Math.sin(rotation), 0],
        [0, +Math.sin(rotation), +Math.cos(rotation), 0],
        [0, 0, 0, 1],
      ]
    end

    it { expect(rotate_x).to eq(result) }
  end

  describe '.rotate_y' do
    subject(:rotate_y) { described_class.rotate_y(rotation) }

    let(:rotation) { Math::PI / 4 }

    let(:result) do
      described_class[
        [+Math.cos(rotation), 0, +Math.sin(rotation), 0],
        [0, 1, 0, 0],
        [-Math.sin(rotation), 0, +Math.cos(rotation), 0],
        [0, 0, 0, 1],
      ]
    end

    it { expect(rotate_y).to eq(result) }
  end

  describe '.rotate_z' do
    subject(:rotate_z) { described_class.rotate_z(rotation) }

    let(:rotation) { Math::PI / 4 }

    let(:result) do
      described_class[
        [+Math.cos(rotation), -Math.sin(rotation), 0, 0],
        [+Math.sin(rotation), +Math.cos(rotation), 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
      ]
    end

    it { expect(rotate_z).to eq(result) }
  end

  describe '#translate' do
    subject(:translate) { identity.translate(1, 2, 3) }

    let(:identity) { build(:transform) }

    it { expect(translate).to eq(described_class.translate(1, 2, 3)) }
  end

  describe '#scale' do
    subject(:scale) { identity.scale(1, 2, 3) }

    let(:identity) { build(:transform) }

    it { expect(scale).to eq(described_class.scale(1, 2, 3)) }
  end

  describe '#rotate_x' do
    subject(:rotate_x) { described_class::IDENTITY.rotate_x(rotation) }

    let(:rotation) { Math::PI }
    let(:identity) { build(:transform) }
    let(:result) { described_class.rotate_x(rotation) }

    it { expect(rotate_x).to eq(result) }
  end

  describe '#rotate_y' do
    subject(:rotate_y) { described_class::IDENTITY.rotate_y(rotation) }

    let(:rotation) { Math::PI }
    let(:identity) { build(:transform) }
    let(:result) { described_class.rotate_y(rotation) }

    it { expect(rotate_y).to eq(result) }
  end

  describe '#rotate_z' do
    subject(:rotate_z) { described_class::IDENTITY.rotate_z(rotation) }

    let(:rotation) { Math::PI / 2 }
    let(:identity) { build(:transform) }
    let(:result) { described_class.rotate_z(rotation) }

    it { expect(rotate_z).to eq(result) }
  end
end
