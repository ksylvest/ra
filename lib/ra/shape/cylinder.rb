# frozen_string_literal: true

module Ra
  module Shape
    # A cylinder at origin <0,0,0> with a radius 1. A cylinder surface is defined:
    #
    #   (x² + z² = radius² AND y BETWEEN ±1) OR (y = ±1 AND x² + z² < radius)
    #
    # A ray `x` / `y` / `z` values at `t` use the `origin` and `direction`:
    #
    #   x = origin.x + direction.x * t
    #   y = origin.y + direction.y * t
    #   z = origin.z + direction.z * t
    #
    # Substituting `x` / `y` / `z` allows for solving for `t`:
    #
    #   (origin.x + direction.x * t)² + (origin.z + direction.z * t)² = 1
    #
    # Simplifying gives a quadratic formula with terms defined as:
    #
    #   a = direction.x² + direction.z²
    #   b = 2 * ((origin.x * direction.x) + (origin.z * direction.z))
    #   c = origin.x² + origin.z² - 1
    #   discriminant = b² - 4ac
    #   t = (-b ± √discriminant) / (2a)
    #
    # A discriminant <0 indicates the ray does not intersect the sphere.
    class Cylinder < Base
      MIN_Y = -1
      MAX_Y = +1
      RADIUS = 1

      # @param point [Vector] <x, y, z, Tuple::POINT>
      # @return [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      def uv_point(point:)
        x = point[0]
        y = point[1]
        z = point[2]

        theta = Math.atan2(x, z)

        u = 1 - ((theta / (2 * Math::PI)) + 0.5)
        v = y % 1.0

        Vector[u, v]
      end

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        t_intersect_caps(ray:) +
          t_intersect_side(ray:).filter { |t| ray.y(t:) > MIN_Y && ray.y(t:) < MAX_Y }
      end

      # @param point [Vector]
      # @return [Ra::Tuple]
      def l_normal(point:)
        x = point[0]
        y = point[1]
        z = point[2]

        distance = (x * x) + (z * z)

        if distance < 1
          return Vector[0, +1, 0, Tuple::VECTOR] if y >= MAX_Y - EPSILON
          return Vector[0, -1, 0, Tuple::VECTOR] if y <= MIN_Y + EPSILON
        end

        Vector[point[0], 0, point[2], Tuple::VECTOR]
      end

      private

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect_side(ray:)
        direction_x = ray.direction_x
        direction_z = ray.direction_z
        origin_x = ray.origin_x
        origin_z = ray.origin_z

        Quadratic.solve(
          a: (direction_x * direction_x) + (direction_z * direction_z),
          b: 2 * ((origin_x * direction_x) + (origin_z * direction_z)),
          c: ((origin_x * origin_x) + (origin_z * origin_z)) - RADIUS,
        )
      end

      def t_intersect_caps(ray:)
        [
          t_intersect_y(ray:, y: MIN_Y),
          t_intersect_y(ray:, y: MAX_Y),
        ].compact
      end

      # @param ray [Ra::Ray] local
      # @return [Numeric, nil]
      def t_intersect_y(ray:, y:)
        t = ray.t_y(y)
        return unless t

        point = ray.position(t:)

        return if (point[0] * point[0]) + (point[2] * point[2]) > RADIUS

        t
      end
    end
  end
end
