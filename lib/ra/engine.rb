# frozen_string_literal: true

module Ra
  # An engine takes a world / camera and generates a PPM.
  class Engine
    include Enumerable

    PRECISION = 255
    PORCESSES = 8

    PPM_VERSION = 'P3'
    PPM_DEFAULT = '0 0 0'

    # @param world [Ra::World]
    # @param camera [Ra::Camera]
    def initialize(world:, camera:)
      @world = world
      @camera = camera
    end

    # @yield [y, x, color] y, x, color
    # @yieldparam [Integer] y
    # @yieldparam [Integer] x
    # @yieldparam [Ra::Color, nil] color
    def each
      @camera.each do |y, x, ray|
        color = @world.color(ray:)
        yield(y, x, color)
      end
    end

    # @yield [text]
    # @yieldparam [String] text
    def ppm
      yield(<<~PPM)
        #{PPM_VERSION}
        #{@camera.w} #{@camera.h}
        #{Color::PRECISION}
      PPM

      each do |_y, _x, color|
        yield(color ? color.ppm : PPM_DEFAULT)
      end
    end
  end
end
