# frozen_string_literal: true

module Ra
  # An engine takes uses a world / camera to generate a canvas.
  class Engine
    PRECISION = 255

    # @param world [Ra::World]
    # @param camera [Ra::Camera]
    def initialize(world:, camera:)
      @world = world
      @camera = camera
    end

    # @return [Ra::Canvas]
    def render
      Ra::Canvas.new(w: @camera.w, h: @camera.h, precision: PRECISION).tap do |canvas|
        @camera.h.times do |y|
          @camera.w.times do |x|
            draw(x:, y:, canvas:)
          end
        end
      end
    end

    private

    # @param x [Integer]
    # @param y [Integer]
    # @param canvas [Ra::Canvas]
    def draw(x:, y:, canvas:)
      ray = @camera.ray(x:, y:)

      canvas[x, y] = @world.color(ray:)
    end
  end
end
