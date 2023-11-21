# frozen_string_literal: true

require 'spec_helper'

describe Ra::Intersection do
  subject(:intersection) { build(:intersection, shape:, ray:) }

  let(:shape) { build(:sphere) }
  let(:ray) { build(:ray) }
  let(:t) { 0.0 }

  it { expect(intersection.shape).to(eq(shape)) }
  it { expect(intersection.ray).to(eq(ray)) }
  it { expect(intersection.t).to(eq(t)) }

  describe '.hit' do
    let(:shape) { build(:sphere) }
    let(:ray) { build(:ray) }
    let(:intersections) do
      [
        build(:intersection, ray:, shape:, t: -3),
        build(:intersection, ray:, shape:, t: -2),
        build(:intersection, ray:, shape:, t: +2),
        build(:intersection, ray:, shape:, t: +3),
      ]
    end

    it do
      expect(described_class.hit(intersections:))
        .to eq(build(:intersection, ray:, shape:, t: 2))
    end
  end
end
