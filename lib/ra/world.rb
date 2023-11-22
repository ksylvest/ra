# frozen_string_literal: true

module Ra
  # A world is composed of objects (lights / cameras) and handles coloring of rays.
  class World
    attr_accessor :light, :shapes

    # @param light [Ra::Light]
    # @param shapes [Array<Ra::Shape>]
    def initialize(light:, shapes:)
      @light = light
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
      shadowed = shadowed?(point: surface.hpoint)

      Lighting.new(shadowed:, surface:, light:).color
    end

    # @param point [Ra::Point]
    def shadowed?(point:)
      vector = @light.position - point
      distance = vector.magnitude
      direction = vector.normalize
      ray = Ray.new(origin: point, direction:)
      hit = intersection(ray:)
      hit && hit.t < distance
    end
  end
end
