# frozen_string_literal: true

require 'spec_helper'

describe Ra::Shape::Cylinder do
  subject(:cylinder) { build(:cylinder) }

  describe '#intersect' do
    subject(:intersect) { cylinder.intersect(ray:) }

    let(:ray) { build(:ray, origin:, direction:) }

    context 'with a ray that intersects in the X' do
      let(:origin) { build(:point, x: 0, y: 0, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: cylinder),
          build(:intersection, t: 6.0, ray:, shape: cylinder),
        ])
      end
    end

    context 'with a ray that intersects in the Z' do
      let(:origin) { build(:point, x: -5, y: 0, z: 0) }
      let(:direction) { build(:vector, x: 1, y: 0, z: 0) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: cylinder),
          build(:intersection, t: 6.0, ray:, shape: cylinder),
        ])
      end
    end
  end

  describe '#normal' do
    subject(:result) { cylinder.normal(point:) }

    context 'when the point is on the x-axis' do
      let(:point) { build(:point, x: 1, y: 0, z: 0) }

      it { expect(result).to eq(build(:vector, x: 1, y: 0, z: 0)) }
    end

    context 'when the point is on the z-axis' do
      let(:point) { build(:point, x: 0, y: 0, z: 1) }

      it { expect(result).to eq(build(:vector, x: 0, y: 0, z: 1)) }
    end

    context 'when the point is on the y-axis (+1)' do
      let(:point) { build(:point, x: 0, y: +1, z: 0) }

      it { expect(result).to eq(build(:vector, x: 0, y: +1, z: 0)) }
    end

    context 'when the point is on the y-axis (-1)' do
      let(:point) { build(:point, x: 0, y: -1, z: 0) }

      it { expect(result).to eq(build(:vector, x: 0, y: -1, z: 0)) }
    end
  end

  describe '#uv_point' do
    subject(:uv_point) { cylinder.uv_point(point:) }

    context 'with a point at x = -1 / y = 0 / z = 0' do
      let(:point) { build(:point, x: -1, y: 0, z: 0) }

      it { expect(uv_point).to eq(Vector[0.75, 0.0]) }
    end

    context 'with a point at x = +1 / y = 0 / z = 0' do
      let(:point) { build(:point, x: +1, y: 0, z: 0) }

      it { expect(uv_point).to eq(Vector[0.25, 0.0]) }
    end

    context 'with a point at x = 0 / y = -1 / z = 0' do
      let(:point) { build(:point, x: 0, y: -1, z: 0) }

      it { expect(uv_point).to eq(Vector[0.5, 0.0]) }
    end

    context 'with a point at x = 0 / y = +1 / z = 0' do
      let(:point) { build(:point, x: 0, y: +1, z: 0) }

      it { expect(uv_point).to eq(Vector[0.5, 0.0]) }
    end

    context 'with a point at x = 0 / y = 0 / z = -1' do
      let(:point) { build(:point, x: 0, y: 0, z: -1) }

      it { expect(uv_point).to eq(Vector[0.0, 0.0]) }
    end

    context 'with a point at x = 0 / y = 0 / z = +1' do
      let(:point) { build(:point, x: 0, y: 0, z: +1) }

      it { expect(uv_point).to eq(Vector[0.5, 0.0]) }
    end
  end
end
