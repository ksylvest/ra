# frozen_string_literal: true

FactoryBot.define do
  factory :world, class: 'Ra::World' do
    initialize_with { new(**attributes) }

    lights { [] }
    shapes { [] }
  end
end
