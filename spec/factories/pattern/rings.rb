# frozen_string_literal: true

FactoryBot.define do
  factory :rings, class: 'Ra::Pattern::Rings', parent: :pattern do
    colors do
      [
        build(:color, :white),
        build(:color, :black),
      ]
    end
  end
end
