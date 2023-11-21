# frozen_string_literal: true

FactoryBot.define do
  factory :checkers, class: 'Ra::Pattern::Checkers', parent: :pattern do
    colors do
      [
        build(:color, :white),
        build(:color, :black),
      ]
    end
  end
end
