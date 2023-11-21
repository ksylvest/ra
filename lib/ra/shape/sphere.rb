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
      protected

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        origin = ray.origin - Vector[0, 0, 0, Ra::Tuple::POINT]
        direction = ray.direction

        quadratic(
          a: direction.dot(direction),
          b: 2 * direction.dot(origin),
          c: origin.dot(origin) - 1,
        )
      end

      # @param point [Vector]
      # @return [Ra::Tuple]
      def l_normal(point:)
        point - Vector[0, 0, 0, Ra::Tuple::VECTOR]
      end

      private

      # (-b ± √(b² - 4ac)) / (2a)
      #
      # @param a [Numeric]
      # @param b [Numeric]
      # @param c [Numeric]
      # @return [Array<Numeric>]
      def quadratic(a:, b:, c:)
        discriminant = (b**2) - (4 * a * c)
        return [] if discriminant.negative?

        [
          (-b - Math.sqrt(discriminant)) / (2 * a),
          (-b + Math.sqrt(discriminant)) / (2 * a),
        ]
      end
    end
  end
end
