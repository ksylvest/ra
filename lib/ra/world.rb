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

    # @param ray [Ra::Ray]
    # @return [Ra::Color]
    def color(ray:, remaining: 4)
      intersection = intersection(ray:)
      return unless intersection

      surface = intersection.surface

      colors = @lights.map do |light|
        shadowed = shadowed?(point: surface.hpoint, light:)
        lighting = Lighting.new(light:, shadowed:, surface:)
        lighting.color
      end

      colors.reduce(&:+) + reflect(surface:, remaining:)
    end

    # @param surface [Ra::Surface]
    # @param remaining [Integer]
    # @return [Ra::Color]
    def reflect(surface:, remaining:)
      return if remaining.zero?

      material = surface.shape.material
      return unless material.reflective.positive?

      ray = Ray.new(origin: surface.hpoint, direction: surface.reflectv)

      color = color(ray:, remaining: remaining.pred)
      color * material.reflective if color
    end

    # @param light [Ra::Light]
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
