# frozen_string_literal: true

require 'spec_helper'

describe Ra::Shape::Cube do
  subject(:cube) { build(:cube) }

  describe '#intersect' do
    subject(:intersect) { cube.intersect(ray:) }

    let(:ray) { build(:ray, origin:, direction:) }

    context 'when origin is at x = 0 / y = 0 / z = -5' do
      let(:origin) { build(:point, x: 0, y: 0, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: cube),
          build(:intersection, t: 6.0, ray:, shape: cube),
        ])
      end
    end

    context 'when origin is at x = 0 / y = 0 / z = 0' do
      let(:origin) { build(:point, x: 0, y: 0, z: 0) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: -1.0, ray:, shape: cube),
          build(:intersection, t: +1.0, ray:, shape: cube),
        ])
      end
    end

    context 'when origin is at x = +0.5 y = +0.5 / z = -5' do
      let(:origin) { build(:point, x: +0.5, y: +0.5, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: cube),
          build(:intersection, t: 6.0, ray:, shape: cube),
        ])
      end
    end

    context 'when origin is at x = -0.5 / y = -0.5 / z = -5' do
      let(:origin) { build(:point, x: -0.5, y: -0.5, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to eq([
          build(:intersection, t: 4.0, ray:, shape: cube),
          build(:intersection, t: 6.0, ray:, shape: cube),
        ])
      end
    end

    context 'when origin is at x = -2 / y = +2 / z = -5' do
      let(:origin) { build(:point, x: -2, y: +2, z: -5) }
      let(:direction) { build(:vector, x: 0, y: 0, z: 1) }

      it do
        expect(intersect).to be_empty
      end
    end
  end

  describe '#normal' do
    subject(:result) { cube.normal(point:) }

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
    subject(:uv_point) { cube.uv_point(point:) }

    context 'with a point at x = -0.5 / y = +0.5 / z = +1.0' do
      let(:point) { build(:point, x: -0.5, y: +0.5, z: +1.0) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = +0.5 / y = -0.5 / z = +1.0' do
      let(:point) { build(:point, x: +0.5, y: -0.5, z: +1.0) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end

    context 'with a point at x = +0.5 / y = +0.5 / z = -1' do
      let(:point) { build(:point, x: +0.5, y: +0.5, z: -1.0) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = -0.5 / y = -0.5 / z = -1.0' do
      let(:point) { build(:point, x: -0.5, y: -0.5, z: -1.0) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end

    context 'with a point at x = -1.0 / y = +0.5 / z = -0.5' do
      let(:point) { build(:point, x: -1.0, y: +0.5, z: -0.5) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = -1.0 / y = -0.5 / z = +0.5' do
      let(:point) { build(:point, x: -1.0, y: -0.5, z: +0.5) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end

    context 'with a point at x = +1.0 / y = +0.5 / z = +0.5' do
      let(:point) { build(:point, x: +1.0, y: +0.5, z: +0.5) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = +1.0 / y = -0.5 / z = -0.5' do
      let(:point) { build(:point, x: +1.0, y: -0.5, z: -0.5) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end

    context 'with a point at x = -0.5 / y = 1.0 / z = -0.5' do
      let(:point) { build(:point, x: -0.5, y: +1.0, z: -0.5) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = +0.5 / y = +1.0 / z = +0.5' do
      let(:point) { build(:point, x: +0.5, y: +1.0, z: +0.5) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end

    context 'with a point at x = -0.5 / y = -1.0 / z = 0.5' do
      let(:point) { build(:point, x: -0.5, y: -1, z: +0.5) }

      it { expect(uv_point).to eq(Vector[0.25, 0.75]) }
    end

    context 'with a point at x = +0.5 / y = -1.0 / z = -0.5' do
      let(:point) { build(:point, x: 0.5, y: -1.0, z: -0.5) }

      it { expect(uv_point).to eq(Vector[0.75, 0.25]) }
    end
  end
end
