# frozen_string_literal: true

FactoryBot.define do
  factory :stripes, class: 'Ra::Pattern::Stripes', parent: :pattern do
    colors do
      [
        build(:color, :white),
        build(:color, :black),
      ]
    end
  end
end
