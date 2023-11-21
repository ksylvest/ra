# frozen_string_literal: true

module Ra
  module Shape
    # An abstract shape. Any concrete subclass of shape must implement the
    # methods `l_normal` and `t_intersect`. Both methods use a point / ray
    # with a local transform applied.
    class Base
      attr_accessor :material, :transform

      # @param material [Ra::Material]
      # @param transform [Ra::Matrix]
      def initialize(material:, transform: Transform::IDENTITY)
        @material = material
        @transform = transform
      end

      # @param ray [Ra::Ray]
      # @return [Array<Ra::Intersection>]
      def intersect(ray:)
        t_intersect(ray: ray.transform(transform.inverse))
          .map { |t| Ra::Intersection.new(ray:, shape: self, t:) }
      end

      # @param point [Vector]
      # @return [Vector]
      def normal(point:)
        normal = transform.inverse.transpose * l_normal(point: transform.inverse * point)

        Vector[normal[0], normal[1], normal[2], Ra::Tuple::VECTOR].normalize
      end

      # @param point [Vector]
      # @return [Color]
      def color(point:)
        @material.color(point: transform.inverse * point)
      end

      private

      # @param ray [Ra::Ray] local
      # @return [Array<Intersection>]
      def t_intersect(ray:)
        raise NotImplementedError, '#t_intersect must be implemented by a concrete subclass'
      end

      # @param point [Vector] local
      # @return [Vector]
      def l_normal(point:)
        raise NotImplementedError, '#l_normal must be implemented by a concrete subclass'
      end
    end
  end
end
