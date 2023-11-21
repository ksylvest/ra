# frozen_string_literal: true

require 'spec_helper'

describe Ra::Surface do
  subject(:surface) { build(:surface) }

  it { expect(surface.shape).to be_a(Ra::Shape::Base) }
  it { expect(surface.eyev).to be_a(Vector) }
  it { expect(surface.normalv).to be_a(Vector) }
  it { expect(surface.point).to be_a(Vector) }
end
