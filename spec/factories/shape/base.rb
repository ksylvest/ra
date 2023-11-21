# frozen_string_literal: true

FactoryBot.define do
  factory :shape, class: 'Ra::Shape::Base' do
    initialize_with { new(**attributes) }

    transform { Ra::Transform::IDENTITY }
    material
  end
end
