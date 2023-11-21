# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Stripes do
  subject(:stripes) { build(:stripes) }

  describe '#color' do
    subject(:color) { stripes.color(point:) }

    context 'with a point at x=0.0 y=0.0 z=0.0' do
      let(:point) { build(:point, x: 0.0, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=0.5 y=0 z=0' do
      let(:point) { build(:point, x: 0.5, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=1.0 y=0 z=0' do
      let(:point) { build(:point, x: 1.0, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at x=1.5 y=0 z=0' do
      let(:point) { build(:point, x: 1.5, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :black)) }
    end
  end
end
