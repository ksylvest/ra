# frozen_string_literal: true

require 'spec_helper'

describe Ra::Material do
  subject(:material) { build(:material) }

  it { expect(material.color).to be_a(Ra::Color) }
  it { expect(material.ambient).to be_a(Numeric) }
  it { expect(material.diffuse).to be_a(Numeric) }
  it { expect(material.specular).to be_a(Numeric) }
  it { expect(material.shininess).to be_a(Numeric) }
end
