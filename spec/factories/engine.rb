# frozen_string_literal: true

FactoryBot.define do
  factory :engine, class: 'Ra::Engine' do
    initialize_with { new(**attributes) }

    camera
    world
  end
end
