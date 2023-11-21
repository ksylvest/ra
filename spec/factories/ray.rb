# frozen_string_literal: true

FactoryBot.define do
  factory :ray, class: 'Ra::Ray' do
    initialize_with { new(**attributes) }

    origin factory: :point
    direction factory: :vector
  end
end
