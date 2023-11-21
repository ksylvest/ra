# frozen_string_literal: true

require 'spec_helper'

describe Ra::Ray do
  subject(:ray) { build(:ray) }

  it { expect(ray.origin).to be_a(Vector) }
  it { expect(ray.direction).to be_a(Vector) }

  describe '#position' do
    let(:ray) { build(:ray, origin:, direction:) }
    let(:origin) { build(:point, x: 2, y: 3, z: 4) }
    let(:direction) { build(:vector, x: 1, y: 0, z: 0) }

    it { expect(ray.position(t: 0)).to eq(build(:point, x: 2, y: 3, z: 4)) }
    it { expect(ray.position(t: 1)).to eq(build(:point, x: 3, y: 3, z: 4)) }
    it { expect(ray.position(t: 2)).to eq(build(:point, x: 4, y: 3, z: 4)) }
  end

  describe '#transform' do
    let(:ray) { build(:ray, origin:, direction:) }
    let(:origin) { build(:point, x: 1, y: 2, z: 3) }
    let(:direction) { build(:vector, x: 0, y: 1, z: 0) }

    context 'when a translate' do
      subject(:transform) { ray.transform(build(:translate, x: 3, y: 4, z: 5)) }

      it { expect(transform).to be_a(described_class) }
      it { expect(transform.origin).to eq(build(:point, x: 4, y: 6, z: 8)) }
      it { expect(transform.direction).to eq(build(:vector, x: 0, y: 1, z: 0)) }
    end

    context 'with a scale' do
      subject(:transform) { ray.transform(build(:scale, x: 1, y: 2, z: 3)) }

      it { expect(transform).to be_a(described_class) }
      it { expect(transform.origin).to eq(build(:point, x: 1, y: 4, z: 9)) }
      it { expect(transform.direction).to eq(build(:vector, x: 0, y: 2, z: 0)) }
    end
  end
end
