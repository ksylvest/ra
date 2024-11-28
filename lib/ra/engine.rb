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

    # @yield [pixel]
    # @yieldparam [Ra::Pixel] pixel
    def each
      @camera.each do |y, x, ray|
        color = @world.color(ray:)
        yield(Ra::Pixel.new(x:, y:, color:))
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

      each do |pixel|
        yield(pixel.color ? pixel.color.ppm : PPM_DEFAULT)
      end
    end
  end
end
