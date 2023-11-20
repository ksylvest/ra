# frozen_string_literal: true

FactoryBot.define do
  factory :color, class: 'Ra::Color' do
    initialize_with { new(**attributes) }

    r { 0.3 }
    g { 0.5 }
    b { 0.7 }

    trait :uniform do
      transient do
        value { 0.5 }
      end

      r { value }
      g { value }
      b { value }
    end

    trait :black do
      r { 0.0 }
      g { 0.0 }
      b { 0.0 }
    end

    trait :white do
      r { 1.0 }
      g { 1.0 }
      b { 1.0 }
    end
  end
end
