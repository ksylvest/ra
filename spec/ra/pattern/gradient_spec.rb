# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Gradient do
  subject(:gradient) { build(:gradient) }

  describe '#color' do
    subject(:color) { gradient.color(point:) }

    context 'with a point at x=0.2 y=0.0 z=0.0' do
      let(:point) { build(:point, x: 0.2, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :uniform, value: 0.8)) }
    end

    context 'with a point at x=0.8 y=0.0 z=0.0' do
      let(:point) { build(:point, x: 0.8, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :uniform, value: 0.2)) }
    end
  end
end
