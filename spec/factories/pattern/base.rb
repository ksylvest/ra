# frozen_string_literal: true

FactoryBot.define do
  factory :pattern, class: 'Ra::Pattern::Base' do
    initialize_with { new(**attributes) }
  end
end
