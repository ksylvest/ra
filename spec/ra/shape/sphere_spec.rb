# frozen_string_literal: true

require 'spec_helper'

describe Ra::Shape::Sphere do
  subject(:sphere) { build(:sphere) }

  describe '#intersect' do
    subject(:intersect) { sphere.intersect(ray:) }

    let(:ray) { build(:ray, origin:, direction:) }

    context 'with a ray that intersects in the center' do
      let(:origin) { build(:point, x: 0, y: 0, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: sphere),
          build(:intersection, t: 6.0, ray:, shape: sphere),
        ])
      end
    end

    context 'with a ray that intersects on the side' do
      let(:origin) { build(:point, x: 0, y: 1, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 5.0, ray:, shape: sphere),
          build(:intersection, t: 5.0, ray:, shape: sphere),
        ])
      end
    end

    context 'with a ray that misses' do
      let(:origin) { build(:point, x: 0, y: 2, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to be_empty
      end
    end
  end

  describe '#normal' do
    subject(:result) { sphere.normal(point:) }

    context 'when the point is on the x-axis' do
      let(:point) { build(:point, x: 1, y: 0, z: 0) }

      it { expect(result).to eq(build(:vector, x: 1, y: 0, z: 0)) }
    end

    context 'when the point is on the y-axis' do
      let(:point) { build(:point, x: 0, y: 1, z: 0) }

      it { expect(result).to eq(build(:vector, x: 0, y: 1, z: 0)) }
    end

    context 'when the point is on the z-axis' do
      let(:point) { build(:point, x: 0, y: 0, z: 1) }

      it { expect(result).to eq(build(:vector, x: 0, y: 0, z: 1)) }
    end
  end

  describe '#uv_point' do
    subject(:uv_point) { sphere.uv_point(point:) }

    context 'with a point at x = -1 / y = 0 / z = 0' do
      let(:point) { build(:point, x: -1, y: 0, z: 0) }

      it { expect(uv_point).to eq(Vector[0.75, 0.5]) }
    end

    context 'with a point at x = +1 / y = 0 / z = 0' do
      let(:point) { build(:point, x: +1, y: 0, z: 0) }

      it { expect(uv_point).to eq(Vector[0.25, 0.5]) }
    end

    context 'with a point at x = 0 / y = -1 / z = 0' do
      let(:point) { build(:point, x: 0, y: -1, z: 0) }

      it { expect(uv_point).to eq(Vector[0.5, 0.0]) }
    end

    context 'with a point at x = 0 / y = +1 / z = 0' do
      let(:point) { build(:point, x: 0, y: +1, z: 0) }

      it { expect(uv_point).to eq(Vector[0.5, 1.0]) }
    end

    context 'with a point at x = 0 / y = 0 / z = -1' do
      let(:point) { build(:point, x: 0, y: 0, z: -1) }

      it { expect(uv_point).to eq(Vector[0.0, 0.5]) }
    end

    context 'with a point at x = 0 / y = 0 / z = +1' do
      let(:point) { build(:point, x: 0, y: 0, z: +1) }

      it { expect(uv_point).to eq(Vector[0.5, 0.5]) }
    end
  end
end
