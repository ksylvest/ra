# frozen_string_literal: true

require 'spec_helper'

describe Ra::Lighting do
  subject(:lighting) { build(:lighting, surface:, light:, shadowed:) }

  let(:surface) { build(:surface) }
  let(:light) { build(:light, intensity: build(:color, :uniform, value: 1.0)) }

  describe '#color' do
    subject(:color) { lighting.color }

    context 'when shadowed = true' do
      let(:shadowed) { true }

      it { expect(color).to eq(build(:color, r: 0.15, g: 0.25, b: 0.35)) }
    end

    context 'when shadowed = false' do
      let(:shadowed) { false }

      it { expect(color).to eq(build(:color, r: 0.15, g: 0.25, b: 0.35)) }
    end
  end
end
