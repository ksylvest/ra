# frozen_string_literal: true

module Ra
  module Pattern
    # A checkers pattern that alternates colors using:
    #
    #   colors[⌊u * rows⌋ + ⌊v * cols)⌋ % colors.count]
    class Checkers < Base
      DEFAULT_ROWS = 2
      DEFAULT_COLS = 2
      DEFAULT_COLORS = [
        Color.black,
        Color.white,
      ].freeze

      # @param rows [Integer]
      # @param cols [Integer]
      # @param colors [Array<Ra::Color>]
      # @param transform [Ra::Matrix]
      def initialize(cols: DEFAULT_COLS, rows: DEFAULT_ROWS, colors: DEFAULT_COLORS)
        super()
        @rows = rows
        @cols = cols
        @colors = colors
      end

      # @param point [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      # @return [Ra::Color]
      def color(point:)
        u = point[0]
        v = point[1]
        index = (u * @rows).floor + (v * @cols).floor

        @colors[index % @colors.count]
      end
    end
  end
end
