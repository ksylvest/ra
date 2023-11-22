# frozen_string_literal: true

module Ra
  module Shape
    # A cube centered at <0,0,0> with sides of l=2. A cube surface is defined:
    #
    #   x between (-1..+1)
    #   y between (-1..+1)
    #   z between (-1..+1)
    #   x = ±1 OR y = ±1 OR z = ±1
    #
    # A ray `x` / `y` / `z` values at `t` use the `origin` and `direction`:
    #
    #   x = origin.x + direction.x * t
    #   y = origin.y + direction.y * t
    #   z = origin.z + direction.z * t
    #
    # The ray therefore may intersect when:
    #
    #   origin.x + direction.x * t = ±1 OR origin.y + direction.y * t = ±1 OR origin.z + direction.z * t = ±1
    #
    # Thus 6 planes can be checked for intersect.
    class Cube < Base
      protected

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        t_min = t_min(ray:)
        t_max = t_max(ray:)

        return [] if !t_min || !t_max || t_min > t_max

        [
          t_min,
          t_max,
        ]
      end

      # @param point [Vector]
      # @return [Ra::Tuple]
      def l_normal(point:)
        x = point[0].abs
        y = point[1].abs
        z = point[2].abs

        Vector[
          (is_x = x > y && x > z) ? 1 : 0,
          (is_y = y > x && y > z) ? 1 : 0,
          is_x || is_y ? 0 : 1,
          Ra::Tuple::VECTOR
        ]
      end

      private

      # @param ray [Ra::Ray]
      # @return [Integer]
      def t_min(ray:)
        (0..2).map { |i| t_min_max(ray.origin[i], ray.direction[i]).min }.max
      end

      # @param ray [Ra::Ray]
      # @return [Integer]
      def t_max(ray:)
        (0..2).map { |i| t_min_max(ray.origin[i], ray.direction[i]).max }.min
      end

      # @param origin [Numeric]
      # @param direction [Numeric]
      # @param value [Numeric]
      # @return [Array<Numeric,Numeric>]
      def t_min_max(origin, direction)
        t_min_numerator = -1 - origin
        t_max_numerator = +1 - origin

        if direction.abs < EPSILON
          t_min = t_min_numerator * Float::INFINITY
          t_max = t_max_numerator * Float::INFINITY
        else
          t_min = t_min_numerator / direction
          t_max = t_max_numerator / direction
        end

        t_min < t_max ? [t_min, t_max] : [t_max, t_min]
      end
    end
  end
end
