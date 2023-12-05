# frozen_string_literal: true

module Ra
  # An intersection tracks the time t at which a shape is intersected by a ray.
  class Intersection
    attr_accessor :t, :ray, :shape

    # @param intersections Array<Ra::Intersection>
    # @return [Ra::Intersection, nil]
    def self.hit(intersections:)
      hit = nil

      intersections.each do |interaction|
        next if interaction.t.negative?

        hit = interaction if hit.nil? || interaction.t < hit.t
      end

      hit
    end

    # @param t [Numeric]
    # @param ray [Ra::Ray]
    # @param shape [Ra::Shape::Base]
    def initialize(t:, ray:, shape:)
      @t = t
      @ray = ray
      @shape = shape
    end

    # @return [Boolean]
    def ==(other)
      t == other.t && ray == other.ray && shape == other.shape
    end

    # @return [Ra::Surface]
    def surface
      point = ray.position(t:)
      eyev = -ray.direction
      normalv = shape.normal(point:)
      reflectv = Tuple.reflect(ray.direction, normalv)

      Surface.new(shape:, eyev:, normalv:, reflectv:, point:)
    end

    # @return [Vector]
    def position
      @position ||= @ray.position(t: @t)
    end

    # @return [Numeric]
    def x
      position[0]
    end

    # @return [Numeric]
    def y
      position[1]
    end

    # @return [Numeric]
    def z
      position[1]
    end
  end
end
