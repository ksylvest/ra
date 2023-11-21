# frozen_string_literal: true

FactoryBot.define do
  factory :surface, class: 'Ra::Surface' do
    initialize_with { new(**attributes) }

    shape factory: :plane
    point factory: :point, x: 0, y: 0, z: 0
    eyev factory: :vector, x: 0, y: +2 * Math.sqrt(2), z: -2 * Math.sqrt(2)
    normalv factory: :vector, x: 0, y: 0, z: -1
  end
end
