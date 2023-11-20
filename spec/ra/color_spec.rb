# frozen_string_literal: true

require 'spec_helper'

describe Ra::Color do
  subject(:color) { build(:color) }

  it { expect(color.r).to eq(0.3) }
  it { expect(color.g).to eq(0.5) }
  it { expect(color.b).to eq(0.7) }

  describe '.hex' do
    subject(:hex) { described_class.hex(value) }

    context 'with the value "#000000"' do
      let(:value) { '#000000' }

      it { expect(hex).to eq(build(:color, :black)) }
    end

    context 'with the value "#FFFFFF"' do
      let(:value) { '#FFFFFF' }

      it { expect(hex).to eq(build(:color, :white)) }
    end
  end

  describe '.black' do
    subject(:black) { described_class.black }

    it { expect(black.r).to eq(0.0) }
    it { expect(black.g).to eq(0.0) }
    it { expect(black.b).to eq(0.0) }
  end

  describe '.white' do
    subject(:white) { described_class.white }

    it { expect(white.r).to eq(1.0) }
    it { expect(white.g).to eq(1.0) }
    it { expect(white.b).to eq(1.0) }
  end

  describe '.uniform' do
    subject(:uniform) { described_class.uniform(0.5) }

    it { expect(uniform.r).to eq(0.5) }
    it { expect(uniform.g).to eq(0.5) }
    it { expect(uniform.b).to eq(0.5) }
  end

  describe '#+' do
    it do
      color_a = build(:color, r: 0.1, g: 0.2, b: 0.3)
      color_b = build(:color, r: 0.2, g: 0.3, b: 0.4)
      expect(color_a + color_b)
        .to eq(build(:color, r: 0.3, g: 0.5, b: 0.7))
    end

    it do
      color = build(:color)
      expect(color + nil).to eq(color)
    end
  end

  describe '# -' do
    it do
      source = build(:color, r: 0.2, g: 0.5, b: 0.7)
      target = build(:color, r: 0.1, g: 0.2, b: 0.3)
      expect(source - target)
        .to eq(build(:color, r: 0.1, g: 0.3, b: 0.4))
    end

    it do
      color = build(:color)
      expect(color - nil).to eq(color)
    end
  end

  describe '#*' do
    it do
      source = build(:color, r: 0.1, g: 0.2, b: 0.3)
      target = build(:color, r: 0.2, g: 0.3, b: 0.4)
      expect(source * target)
        .to eq(build(:color, r: 0.02, g: 0.06, b: 0.12))
    end
  end

  describe '#/' do
    it do
      source = build(:color, r: 0.1, g: 0.2, b: 0.3)
      target = build(:color, r: 0.2, g: 0.4, b: 0.6)
      expect(source / target)
        .to eq(build(:color, r: 0.5, g: 0.5, b: 0.5))
    end
  end
end
