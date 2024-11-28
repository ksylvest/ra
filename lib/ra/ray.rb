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
    # @!attribute origin
    #   @return [Vector]
    attr_accessor :origin

    # @!attribute direction
    #   @return [Vector]
    attr_accessor :direction

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

    # @param t [Numeric]
    # @return [Numeric]
    def x(t:)
      origin_x + (direction_x * t)
    end

    # @param t [Numeric]
    # @return [Numeric]
    def y(t:)
      origin_y + (direction_y * t)
    end

    # @param t [Numeric]
    # @return [Numeric]
    def z(t:)
      origin_z + (direction_z * t)
    end

    # The time t when the ray is at x
    # @param x [Numeric]
    # @return [Numeric]
    def t_x(x)
      return if direction_x.zero?

      (x - origin_x) / direction_x
    end

    # The time t when the ray is at y
    # @param y [Numeric]
    # @return [Numeric, nil]
    def t_y(y)
      return if direction_y.zero?

      (y - origin_y) / direction_y
    end

    # The time t when the ray is at z
    # @param z [Numeric]
    # @return [Numeric, nil]
    def t_z(z)
      return if direction_z.zero?

      (z - origin_z) / direction_z
    end

    # @return [Numeric]
    def direction_x
      @direction[0]
    end

    # @return [Numeric]
    def direction_y
      @direction[1]
    end

    # @return [Numeric]
    def direction_z
      @direction[2]
    end

    # @return [0] 0 = vector / 1 = point
    def direction_w
      @direction[3]
    end

    # @return [Numeric]
    def origin_x
      @origin[0]
    end

    # @return [Numeric]
    def origin_y
      @origin[1]
    end

    # @return [Numeric]
    def origin_z
      @origin[2]
    end

    # @return [1] 0 = vector / 1 = point
    def origin_w
      @origin[3]
    end
  end
end
