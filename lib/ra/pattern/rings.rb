# frozen_string_literal: true

module Ra
  module Pattern
    # A rings pattern that alternates colors using:
    #
    #   colors[⌊√(u² + v²)⌋]
    class Rings < Base
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
        index = Math.sqrt((u**2) + (v**2)).floor

        @colors[index % @colors.count]
      end
    end
  end
end
