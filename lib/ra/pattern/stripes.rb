# frozen_string_literal: true

module Ra
  module Pattern
    # A stripe pattern that alternates colors using:
    #
    #   colors[⌊point.x⌋]
    class Stripes < Base
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
        index = x.floor

        colors[index % colors.count]
      end
    end
  end
end
