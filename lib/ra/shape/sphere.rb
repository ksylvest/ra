# frozen_string_literal: true

module Ra
  module Shape
    # A sphere at origin <0,0,0> with a radius 1. A sphere surface is defined:
    #
    #   x² + y² + z² = radius²
    #
    # A unit radius simplifies further:
    #
    #   x² + y² + z² = 1
    #
    # A ray `x` / `y` / `z` values at `t` use the `origin` and `direction`:
    #
    #   x = origin.x + direction.x * t
    #   y = origin.y + direction.y * t
    #   z = origin.z + direction.z * t
    #
    # Substituting `x` / `y` / `z` allows for solving for `t`:
    #
    #   1 = (origin.x + direction.x * t)²
    #     + (origin.y + direction.y * t)²
    #     + (origin.z + direction.z * t)²
    #
    # Simplifying gives us a quadratic formula with terms defined as:
    #
    #   a = direction.x² + direction.y² + direction.z²
    #   b = 2 * ((origin.x * direction.x) + (origin.y * direction.y) + (origin.z * direction.z))
    #   c = origin.x² + origin.y² + origin.z² - 1
    #   discriminant = b² - 4ac
    #   t = (-b ± √discriminant) / (2a)
    #
    # A discriminant <0 indicates the ray does not intersect the sphere.
    class Sphere < Base
      RADIUS = 1

      # @param point [Vector] <x, y, z, Tuple::POINT>
      # @return [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      def uv_point(point:)
        x = point[0]
        y = point[1]
        z = point[2]

        radius = Vector[x, y, z].magnitude
        theta = Math.atan2(x, z)
        phi = Math.acos(y / radius)

        u = 1 - ((theta / (2 * Math::PI)) + 0.5)
        v = 1 - (phi / Math::PI)

        Vector[u, v]
      end

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        origin = ray.origin - Vector[0, 0, 0, Ra::Tuple::POINT]
        direction = ray.direction

        Quadratic.solve(
          a: direction.dot(direction),
          b: 2 * direction.dot(origin),
          c: origin.dot(origin) - RADIUS,
        )
      end

      # @param point [Vector]
      # @return [Ra::Tuple]
      def l_normal(point:)
        point - Vector[0, 0, 0, Ra::Tuple::VECTOR]
      end
    end
  end
end
