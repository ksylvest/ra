# frozen_string_literal: true

FactoryBot.define do
  factory :lighting, class: 'Ra::Lighting' do
    initialize_with { new(**attributes) }

    surface
    light
  end
end
