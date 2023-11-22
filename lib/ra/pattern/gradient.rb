# frozen_string_literal: true

module Ra
  module Pattern
    # A graident pattern from `color_a` to `color_b` using:
    #
    #   color_b + (color_b - color_a) * (u + v) / 2
    class Gradient < Base
      # @param color_a [Ra::Color]
      # @param color_b [Ra::Color]
      def initialize(color_a:, color_b:)
        super()
        @color_a = color_a
        @color_b = color_b
      end

      # @param point [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      # @return [Ra::Color]
      def color(point:)
        u = point[0]
        v = point[1]
        value = (u + v) / 2

        @color_a + ((@color_b - @color_a) * value)
      end
    end
  end
end
