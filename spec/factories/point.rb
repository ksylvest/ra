# frozen_string_literal: true

FactoryBot.define do
  factory :point, class: 'Ra::Tuple', parent: :tuple do
    w { Ra::Tuple::POINT }
  end
end
