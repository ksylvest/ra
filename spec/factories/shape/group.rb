# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: 'Ra::Shape::Group', parent: :shape do
    shapes { [] }
  end
end
