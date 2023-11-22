# frozen_string_literal: true

FactoryBot.define do
  factory :gradient, class: 'Ra::Pattern::Gradient', parent: :pattern do
    color_a factory: %i[color black]
    color_b factory: %i[color white]
  end
end
