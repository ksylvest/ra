# frozen_string_literal: true

module Ra
  # A world is composed of objects (lights / cameras) and handles coloring of rays.
  class World
    # @param lights [Ra::Light]
    # @param shapes [Array<Ra::Shape>]
    def initialize(lights:, shapes:)
      @lights = lights
      @shapes = shapes
    end

    # @param ray [Ra::Ray]
    # @return [Array<Ra::Intersection>]
    def intersect(ray:)
      @shapes
        .map { |shape| shape.intersect(ray:) }
        .reduce(:concat) || []
    end

    # @return [Ra::Intersection, nil]
    def intersection(ray:)
      intersections = intersect(ray:)
      Intersection.hit(intersections:)
    end

    # @param intersection [Ra::Intersection]
    # @return [Ra::Color]
    def color(intersection:)
      surface = intersection.surface
      point = surface.hpoint

      colors = @lights.map do |light|
        shadowed = shadowed?(point:, light:)
        lighting = Lighting.new(surface:, light:, shadowed:)
        lighting.color
      end

      colors.reduce(&:+)
    end

    # @param point [Ra::Point]
    def shadowed?(light:, point:)
      vector = light.position - point
      distance = vector.magnitude
      direction = vector.normalize
      ray = Ray.new(origin: point, direction:)
      hit = intersection(ray:)
      hit && hit.t < distance
    end
  end
end
