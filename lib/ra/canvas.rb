# frozen_string_literal: true

module Ra
  # A canvas is used to track pixels at <x,y> coordinates. It is given a w / h
  # and on initialization allocates a w by h collection of pixels. For example,
  # defining a basic black and white checkboard canvas with altering squares
  # then saving as [PPM](https://netpbm.sourceforge.net/doc/ppm.html):
  #
  #   canvas = Ra::Canvas.new(w: 4, h: 5, precision: 15)
  #   canvas.w.times do |x|
  #     canvas.h.times do |y|
  #       canvas[x,y] = (x + y) % 2 == 0 ? Ra::Color.black : Ra::Color.white
  #     end
  #   end
  #   canvas.ppm
  class Canvas
    attr_accessor :w, :h, :precision

    DEFAULT_COLOR = Color.black
    private_constant :DEFAULT_COLOR

    DEFAULT_PRECISION = 255
    private_constant :DEFAULT_PRECISION

    PPM_VERSION = 'P3'
    private_constant :PPM_VERSION

    # @param w [Integer]
    # @param h [Integer]
    # @param precision [Integer]
    def initialize(w:, h:, precision: DEFAULT_PRECISION)
      @w = w
      @h = h
      @precision = precision
      @pixels = Array.new(w) { Array.new(h) }
    end

    # @param x [Integer]
    # @param y [Integer]
    def [](x, y)
      raise ArgumentError, "x=#{x} cannot be negative" if x.negative?
      raise ArgumentError, "y=#{y} cannot be negative" if y.negative?
      raise ArgumentError, "x=#{x} must be < #{@w}" unless x < @w
      raise ArgumentError, "y=#{y} must be < #{@h}" unless y < @h

      @pixels[x][y] || DEFAULT_COLOR
    end

    # @param x [Integer]
    # @param y [Integer]
    # @param color [Ra::Color]
    def []=(x, y, color)
      raise ArgumentError, "x=#{x} cannot be negative" if x.negative?
      raise ArgumentError, "y=#{y} cannot be negative" if y.negative?
      raise ArgumentError, "x=#{x} must be < #{@w}" unless x < @w
      raise ArgumentError, "y=#{y} must be < #{@h}" unless y < @h

      @pixels[x][y] = color
    end

    # @return [String]
    def ppm
      buffer = String.new(<<~PPM, encoding: 'ascii')
        #{PPM_VERSION}
        #{@w} #{@h}
        #{@precision}
      PPM

      @h.times do |y|
        @w.times do |x|
          buffer << (self[x, y].ppm(precision: @precision)) << "\n"
        end
      end

      buffer
    end
  end
end
