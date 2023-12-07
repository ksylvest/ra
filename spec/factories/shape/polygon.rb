# frozen_string_literal: true

FactoryBot.define do
  factory :polygon, class: 'Ra::Shape::Polygon', parent: :shape do
    p1 factory: :vector, x: -1, y: 0, z: 0
    p2 factory: :vector, x: +1, y: 0, z: 0
    p3 factory: :vector, x: 0, y: +1, z: 0
  end
end
