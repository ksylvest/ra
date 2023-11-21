# frozen_string_literal: true

module Ra
  # A ray is positioned at an origin travelling by a direction. A ray is cast and used to identify collisions with
  # objects. For example:
  #
  #   ray = Ra::Ray.new(
  #     origin: Vector[0, 0, 0, Ra::Tuple::POINT],
  #     direction: Vector[1, 2, 3, Ra::Tuple::VECTOR],
  #   )
  #   ray.position(t: 1) == Vector[1, 2, 3, Ra::Tuple::VECTOR]
  #   ray.position(t: 2) == Vector[2, 4, 6, Ra::Tuple::VECTOR]
  #   ray.position(t: 3) == Vector[3, 6, 9, Ra::Tuple::VECTOR]
  #
  # A ray can be transformed. This is useful when considering the ray relative to an object that has a transform
  # associated with it. For example:
  #
  #   ray = Ra::Ray.new(
  #     origin: Vector[0, 0, 0, Ra::Tuple::POINT],
  #     direction: Vector[1, 2, 3, Ra::Tuple::VECTOR],
  #   )
  #   ray.transform(transform: Ra::Transform.scale(1, 2, 3))
  class Ray
    attr_accessor :origin, :direction

    # @param origin [Vector] e.g. Vector[1, 2, 3, Ra::Tuple::POINT]
    # @param direction [Vector] e.g. Vector[1, 2, 3, Ra::Tuple::VECTOR]
    def initialize(origin:, direction:)
      @origin = origin
      @direction = direction
    end

    # @param t [Numeric]
    # @return [Vector]
    def position(t:)
      @origin + (@direction * t)
    end

    # @param transform [Ra::Transform]
    # @return [Ra::Ray]
    def transform(transform)
      self.class.new(
        origin: transform * @origin,
        direction: transform * @direction,
      )
    end

    # @return [Boolean]
    def ==(other)
      origin == other.origin && direction == other.direction
    end
  end
end
