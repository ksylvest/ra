# frozen_string_literal: true

FactoryBot.define do
  factory :camera, class: 'Ra::Camera' do
    initialize_with { new(**attributes) }

    transform { Ra::Transform::IDENTITY }
    w { 2 }
    h { 2 }
    fov { Math::PI / 2 }
  end
end
