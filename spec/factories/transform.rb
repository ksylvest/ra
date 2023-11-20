# frozen_string_literal: true

FactoryBot.define do
  factory :transform, class: 'Ra::Transform' do
    initialize_with { Ra::Transform[*values] }

    values do
      [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
      ]
    end
  end

  factory :translate, class: 'Ra::Transform' do
    initialize_with { Ra::Transform.translate(x, y, z) }

    x { 1 }
    y { 2 }
    z { 3 }
  end

  factory :scale, class: 'Ra::Transform' do
    initialize_with { Ra::Transform.scale(x, y, z) }

    x { 1 }
    y { 2 }
    z { 3 }
  end

  factory :rotate_x, class: 'Ra::Transform' do
    initialize_with { Ra::Transform.rotate_x(value) }

    value { Math::PI / 4 }
  end

  factory :rotate_y, class: 'Ra::Transform' do
    initialize_with { Ra::Transform.rotate_y(value) }

    value { Math::PI / 4 }
  end

  factory :rotate_z, class: 'Ra::Transform' do
    initialize_with { Ra::Transform.rotate_z(value) }

    value { Math::PI / 4 }
  end
end
