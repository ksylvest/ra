# frozen_string_literal: true

require 'spec_helper'

describe Ra::World do
  subject(:world) { build(:world, lights: [light], shapes: [shape]) }

  let(:light) { build(:light) }
  let(:shape) { build(:sphere) }

  describe '#intersect' do
    subject(:intersect) { world.intersect(ray:) }

    let(:ray) { build(:ray, origin: build(:point, x: 0, y: 0, z: -4), direction: build(:vector, x: 0, y: 0, z: 2)) }

    it { expect(intersect).to include(build(:intersection, ray:, shape:, t: 1.5)) }
    it { expect(intersect).to include(build(:intersection, ray:, shape:, t: 2.5)) }
  end

  describe '#color' do
    subject(:color) { world.color(ray:) }

    context 'with a ray on the inside of the shape' do
      let(:ray) { build(:ray, origin: build(:point, x: 0, y: 0, z: -5), direction: build(:vector, x: 0, y: 0, z: 1)) }

      it { expect(color).to be_a(Ra::Color) }
    end

    context 'with a ray on the outside of the shape' do
      let(:ray) { build(:ray, origin: build(:point, x: 0, y: 0, z: 0), direction: build(:vector, x: 0, y: 0, z: 1)) }

      it { expect(color).to be_a(Ra::Color) }
    end
  end

  describe '#shadowed?' do
    subject(:shadowed?) { world.shadowed?(point:, light:) }

    let(:light) { build(:light, position: build(:point, x: 0, y: 0, z: -5)) }
    let(:sphere) { build(:sphere) }

    context 'when a point not obstructed by a light' do
      let(:point) { build(:point, x: 0, y: 0, z: -3) }

      it { expect(shadowed?).to be_falsey }
    end

    context 'with a point is obstructed by a light' do
      let(:point) { build(:point, x: 0, y: 0, z: +3) }

      it { expect(shadowed?).to be_truthy }
    end
  end
end
