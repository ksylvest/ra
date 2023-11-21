# frozen_string_literal: true

module Ra
  module Pattern
    # A rings pattern that alternates colors using:
    #
    #   colors[⌊√(point.x² + point.z²)⌋]
    class Rings < Base
      attr_accessor :colors

      # @param colors [Array<Rays::Color>]
      # @param transform [Rays::Matrix]
      def initialize(colors:, transform: DEFAULT_TRANSFORM)
        super(transform:)
        @colors = colors
      end

      protected

      # @param local_point [Vector]
      # @return [Rays::Color]
      def local_color(local_point:)
        x = local_point[0]
        z = local_point[2]
        index = Math.sqrt((x**2) + (z**2)).floor

        colors[index % colors.count]
      end
    end
  end
end
