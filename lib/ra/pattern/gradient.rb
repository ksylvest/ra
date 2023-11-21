# frozen_string_literal: true

module Ra
  module Pattern
    # A graident pattern from `color_a` to `color_b` using:
    #
    #   color_b + (color_b - color_a) * (point.x - point.x.floor)
    class Gradient < Base
      # @param color_a [Ra::Color]
      # @param color_b [Ra::Color]
      # @param transform [Ra::Matrix]
      def initialize(color_a:, color_b:, transform: Transform::IDENTITY)
        super(transform:)
        @color_a = color_a
        @color_b = color_b
      end

      protected

      # @param local_point [Vector]
      # @return [Ra::Color]
      def local_color(local_point:)
        value = local_point[0]
        fraction = value - value.floor
        @color_a + ((@color_b - @color_a) * fraction)
      end
    end
  end
end
