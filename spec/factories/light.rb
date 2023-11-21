# frozen_string_literal: true

FactoryBot.define do
  factory :light, class: 'Ra::Light' do
    initialize_with { new(**attributes) }

    intensity factory: :color
    position factory: :point
  end
end
