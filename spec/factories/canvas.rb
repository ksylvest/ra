# frozen_string_literal: true

FactoryBot.define do
  factory :canvas, class: 'Ra::Canvas' do
    initialize_with { new(**attributes) }

    w { 5 }
    h { 3 }
  end
end
