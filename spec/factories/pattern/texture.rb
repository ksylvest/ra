# frozen_string_literal: true

FactoryBot.define do
  factory :texture, class: 'Ra::Pattern::Texture', parent: :pattern do
    path { File.join(File.dirname(__FILE__), 'texture/sample.png') }
  end
end
