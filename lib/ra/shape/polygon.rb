# frozen_string_literal: true

module Ra
  module Shape
    # A polygon represents three points (p1 / p2 / p3)
    class Polygon
      # @param p1 [Vector]
      # @param p2 [Vector]
      # @param p3 [Vector]
      # @param material [Ra::Material]
      def initialize(p1:, p2:, p3:, material:)
        super(material:)
        @p1 = p1
        @p2 = p2
        @p3 = p3
        @e1 = @p2 - @p1
        @e2 = @p3 - @p1
        @normal = Tuple.cross(@e2, @e1).normalize
      end

      # @param ray [Ra::Ray] local
      # @return [Array<Numeric>]
      def t_intersect(ray:)
        determinant = @e1.dot(Tuple.cross(ray.direction, @e2))
        [] if determinant.abs
      end

      # @param point [Vector]
      # @return [Ra::Tuple]
      def l_normal(*)
        @normal
      end
    end
  end
end
