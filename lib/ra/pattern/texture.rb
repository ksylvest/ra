# frozen_string_literal: true

require 'mini_magick'

module Ra
  module Pattern
    # A texture that can load an AVIF / JPG / PNG / BMP:
    #
    #   colors[⌊point.x⌋]
    class Texture < Base
      # @param path [Pathname]
      def initialize(path:)
        super()
        @path = path
      end

      # @param point [Array<Numeric,Numeric>] <u = 0.0..1.0, v = 0.0..1.0>
      # @return [Ra::Color]
      def color(point:)
        pixel = pixel(point:)

        Color.new(
          r: Float(pixel[0]) / Color::PRECISION,
          g: Float(pixel[1]) / Color::PRECISION,
          b: Float(pixel[2]) / Color::PRECISION,
        )
      end

      private

      # @return [Array<0..255,0..255,0..255>]
      def pixel(point:)
        u = point[0]
        v = 1.0 - point[1]

        x = (u * image.width.pred).round
        y = (v * image.height.pred).round

        pixels[y][x]
      end

      # @return [Array<Array<0..255,0..255,0.255>>]
      def pixels
        @pixels ||= image.get_pixels
      end

      def image
        @image ||= MiniMagick::Image.open(@path)
      end
    end
  end
end
