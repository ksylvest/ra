# frozen_string_literal: true

module Ra
  # A pixel is a point in an image. It pairs the coordinates (x,y) with the color for that point.
  class Pixel
    # @!attribute x
    #   @return [Integer]
    attr_accessor :x

    # @!attribute y
    #   @return [Integer]
    attr_accessor :y

    # @!attribute color
    #   @return [Ra::Color]
    attr_accessor :color

    # @param x [Integer]
    # @param y [Integer]
    # @param color [Ra::Color]
    def initialize(x:, y:, color:)
      @x = x
      @y = y
      @color = color
    end
  end
end
