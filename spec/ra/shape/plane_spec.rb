# frozen_string_literal: true

require 'spec_helper'

describe Ra::Shape::Plane do
  subject(:plane) { build(:plane) }

  describe '#intersect' do
    subject(:intersect) { plane.intersect(ray:) }

    let(:ray) { build(:ray, origin:, direction:) }

    context 'when the ray intersects the plane' do
      let(:origin) { build(:point, x: 0, y: -4, z: 0) }
      let(:direction) { build(:vector, x: 0, y: 1, z: 0) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: plane),
        ])
      end
    end

    context 'when the ray does not intersect the plane' do
      let(:origin) { build(:point, x: 0, y: -4, z: 0) }
      let(:direction) { build(:vector, x: 1, y: 0, z: 1) }

      it do
        expect(intersect).to be_empty
      end
    end
  end

  describe '#normal' do
    subject(:result) { plane.normal(point:) }

    let(:point) { build(:point) }

    it { expect(result).to eq(build(:vector, x: 0, y: 1, z: 0)) }
  end

  describe '#uv_point' do
    subject(:uv_point) { plane.uv_point(point:) }

    context 'with a point at x = 2 / y = 3 / z = 4' do
      let(:point) { build(:point, x: 2, y: 4, z: 3) }

      it 'maps x to u and z to v' do
        expect(uv_point).to eq(Vector[0, 0])
      end
    end
  end
end
