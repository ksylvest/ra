# frozen_string_literal: true

require 'spec_helper'

describe Ra::Shape::Base do
  subject(:shape) { build(:shape) }

  it { expect(shape.material).to be_a(Ra::Material) }

  describe '#color' do
    subject(:color) { shape.color(point:) }

    let(:shape) { build(:shape, material:) }
    let(:material) { build(:material) }
    let(:point) { build(:point) }

    it 'proxies' do
      allow(shape).to receive(:uv_point) { point }
      allow(material).to receive(:color)
      color
      expect(material).to have_received(:color).with(point:)
    end
  end

  describe '#normal' do
    subject(:normal) { shape.normal(point:) }

    let(:point) { build(:point) }

    it do
      expect { normal }
        .to raise_error(NotImplementedError, '#l_normal must be implemented by a concrete subclass')
    end
  end

  describe '#intersect' do
    subject(:interesect) { shape.intersect(ray:) }

    let(:ray) { build(:ray) }

    it do
      expect { interesect }
        .to raise_error(NotImplementedError, '#t_intersect must be implemented by a concrete subclass')
    end
  end
end
