# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Stripes do
  subject(:stripes) { build(:stripes) }

  describe '#color' do
    subject(:color) { stripes.color(point:) }

    let(:point) { Vector[u, v, 0, Ra::Tuple::POINT] }

    context 'with a point at u = 0.0 / v = 0.0' do
      let(:u) { 0.0 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at u = 0.25 / v = 0.0' do
      let(:u) { 0.25 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.0 / v = 0.25' do
      let(:u) { 0.0 }
      let(:v) { 0.25 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.5 / v = 0.0' do
      let(:u) { 0.5 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at u = 0.0 / v = 0.5' do
      let(:u) { 0.0 }
      let(:v) { 0.5 }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at u = 0.75 / v = 0.0' do
      let(:u) { 0.75 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.0 / v = 0.75' do
      let(:u) { 0.0 }
      let(:v) { 0.75 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 1.0 / v = 0.0' do
      let(:u) { 1.0 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at u = 0.0 / v = 1.0' do
      let(:u) { 0.0 }
      let(:v) { 1.0 }

      it { expect(color).to eq(build(:color, :white)) }
    end

    context 'with a point at u = 1.0 / v = 1.0' do
      let(:u) { 1.0 }
      let(:v) { 1.0 }

      it { expect(color).to eq(build(:color, :white)) }
    end
  end
end
