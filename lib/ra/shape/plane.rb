# frozen_string_literal: true

module Ra
  module Shape
    # A plane for all x / z where y = 0. A plane surface is defined:
    #
    #   y = 0
    #
    # A ray `x` / `y` / `z` values at `t` use the `origin` and `direction`:
    #
    #   x = origin.x + direction.x * t
    #   y = origin.y + direction.y * t
    #   z = origin.z + direction.z * t
    #
    # Therefore, a plane has a single intersection at:
    #
    #   t = -origin.y / direction.y
    #
    # A direction.y < EPISLON indicates the ray does not intersect the plane.
    class Plane < Base
      # @param point [Vector] <x, y, z, Tuple::POINT>
      # @return [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      def uv_point(point:)
        Vector[
          point[0] % 1, # u = x % 1
          point[2] % 1, # v = y % 2
        ]
      end

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        origin_y = ray.origin_y
        direction_y = ray.direction_y

        return [] if direction_y.abs < EPSILON

        [-origin_y / direction_y]
      end

      # @return [Ra::Tuple]
      def l_normal(*)
        Vector[
          0,
          1,
          0,
          Ra::Tuple::VECTOR,
        ]
      end
    end
  end
end
