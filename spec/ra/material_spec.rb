# frozen_string_literal: true

require 'spec_helper'

describe Ra::Material do
  subject(:material) { build(:material) }

  it { expect(material.base).to be_a(Ra::Color) }
  it { expect(material.ambient).to be_a(Numeric) }
  it { expect(material.diffuse).to be_a(Numeric) }
  it { expect(material.specular).to be_a(Numeric) }
  it { expect(material.shininess).to be_a(Numeric) }

  describe '#color' do
    subject(:color) { material.color(point:) }

    let(:material) { build(:material, base:) }
    let(:point) { build(:point) }

    context 'when base is a color' do
      let(:base) { build(:color) }

      it { expect(color).to eq(base) }
    end

    context 'when base is a pattern' do
      let(:base) { build(:pattern) }

      it 'proxies' do
        allow(base).to receive(:color)
        color
        expect(base).to have_received(:color).with(point:)
      end
    end
  end
end
