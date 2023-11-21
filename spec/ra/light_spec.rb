# frozen_string_literal: true

require 'spec_helper'

describe Ra::Light do
  subject(:light) { build(:light) }

  it { expect(light.intensity).to be_a(Ra::Color) }
  it { expect(light.position).to be_a(Vector) }
end
