# frozen_string_literal: true

FactoryBot.define do
  factory :tuple, class: 'Vector' do
    initialize_with { Vector[x, y, z, w] }

    x { 1 }
    y { 2 }
    z { 3 }
  end
end
