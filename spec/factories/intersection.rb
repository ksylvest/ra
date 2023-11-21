# frozen_string_literal: true

FactoryBot.define do
  factory :intersection, class: 'Ra::Intersection' do
    initialize_with { new(**attributes) }

    t { 0 }
    ray
    shape
  end
end
