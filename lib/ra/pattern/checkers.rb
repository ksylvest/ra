# frozen_string_literal: true

module Ra
  module Pattern
    # A checkers pattern that alternates colors using:
    #
    #   colors[⌊√(point.x² + point.z²)⌋]
    class Checkers < Base
      attr_accessor :colors

      # @param colors [Array<Ra::Color>]
      # @param transform [Ra::Matrix]
      def initialize(colors:, transform: Transform::IDENTITY)
        super(transform:)
        @colors = colors
      end

      protected

      # @param local_point [Vector]
      # @return [Ra::Color]
      def local_color(local_point:)
        x = local_point[0]
        y = local_point[1]
        z = local_point[2]
        index = x.floor + y.floor + z.floor

        colors[index % colors.count]
      end
    end
  end
end
