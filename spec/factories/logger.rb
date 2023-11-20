# frozen_string_literal: true

FactoryBot.define do
  factory :logger, class: 'Ra::Logger' do
    initialize_with { new(**attributes) }

    stream { instance_double(IO) }
  end
end
