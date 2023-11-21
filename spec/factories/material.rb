# frozen_string_literal: true

FactoryBot.define do
  factory :material, class: 'Ra::Material' do
    initialize_with { new(**attributes) }

    color
    ambient { 0.5 }
    diffuse { 0.5 }
    specular { 0.5 }
    shininess { 20 }
  end
end
