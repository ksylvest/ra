# frozen_string_literal: true

module Ra
  module Pattern
    # A stripe pattern that alternates colors using:
    #
    #   colors[⌊point.x⌋]
    class Stripes < Base
      # @param colors [Array<Ra::Color>]
      def initialize(colors:)
        super()
        @colors = colors
      end

      # @param point [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      # @return [Ra::Color]
      def color(point:)
        u = point[0]
        v = point[1]
        value = (u + v) / 2

        @colors[(value * @colors.count).floor % @colors.count]
      end
    end
  end
end
