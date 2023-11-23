# frozen_string_literal: true

module Ra
  # A surface contains everything needed to apply lighting.
  class Surface
    attr_accessor :eyev, :normalv, :reflectv, :shape, :point

    # @param eyev [Vector]
    # @param normalv [Vector]
    # @param shape [Ra::Shape]
    # @param point [Vector]
    def initialize(eyev:, normalv:, reflectv:, shape:, point:)
      @eyev = eyev
      @normalv = normalv.dot(eyev).negative? ? -normalv : +normalv
      @reflectv = reflectv
      @shape = shape
      @point = point
    end

    # @return [Vector]
    def hpoint
      @hpoint ||= point + (normalv * EPSILON)
    end
  end
end
