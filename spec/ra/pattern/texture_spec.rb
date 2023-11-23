# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Texture do
  subject(:texture) { build(:texture) }

  describe '#color' do
    subject(:color) { texture.color(point:) }

    let(:point) { Vector[u, v] }

    context 'with a point at u = 0.0 / v = 0.0' do
      let(:u) { 0.0 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.5 / v = 0.0' do
      let(:u) { 0.5 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.0 / v = 0.5' do
      let(:u) { 0.0 }
      let(:v) { 0.5 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 1.0 / v = 0.0' do
      let(:u) { 1.0 }
      let(:v) { 0.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 0.0 / v = 1.0' do
      let(:u) { 0.0 }
      let(:v) { 1.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end

    context 'with a point at u = 1.0 / v = 1.0' do
      let(:u) { 1.0 }
      let(:v) { 1.0 }

      it { expect(color).to eq(build(:color, :black)) }
    end
  end
end
