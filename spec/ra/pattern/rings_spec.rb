# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Rings do
  subject(:rings) { build(:rings) }

  describe '#color' do
    subject(:color) { rings.color(point:) }

    context 'with a point at x=0.0 y=0.0 z=0.0' do
      let(:point) { build(:point, x: 0.0, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=0.5 y=0 z=0' do
      let(:point) { build(:point, x: 0.5, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=0.0 y=0 z=0.5' do
      let(:point) { build(:point, x: 0.0, y: 0.0, z: 0.5) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=0.5 y=0 z=0.5' do
      let(:point) { build(:point, x: 0.5, y: 0.0, z: 0.5) }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at x=0.8 y=0 z=0.8' do
      let(:point) { build(:point, x: 0.8, y: 0.0, z: 0.8) }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at x=1.0 y=0 z=0' do
      let(:point) { build(:point, x: 1.0, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at x=0.0 y=0 z=1.0' do
      let(:point) { build(:point, x: 0.0, y: 0.0, z: 1.0) }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at x=1.5 y=0 z=0' do
      let(:point) { build(:point, x: 1.5, y: 0.0, z: 0.0) }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at x=0.0 y=0 z=1.5' do
      let(:point) { build(:point, x: 0.0, y: 0.0, z: 1.5) }

      it { expect(color).to eq(build(:color, :black)) }
    end
  end
end
