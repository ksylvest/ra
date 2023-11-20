# frozen_string_literal: true

FactoryBot.define do
  factory :vector, class: 'Ra::Tuple', parent: :tuple do
    w { Ra::Tuple::VECTOR }
  end
end
