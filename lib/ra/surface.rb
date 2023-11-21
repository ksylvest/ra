# frozen_string_literal: true

module Ra
  # A surface contains everything needed to apply lighting.
  class Surface
    attr_accessor :eyev, :normalv, :shape, :point

    # @param eyev [Vector]
    # @param normalv [Vector]
    # @param shape [Ra::Shape]
    # @param point [Vector]
    def initialize(eyev:, normalv:, shape:, point:)
      @eyev = eyev
      @normalv = normalv.dot(eyev).negative? ? -normalv : +normalv
      @shape = shape
      @point = point
    end

    # @return [Vector]
    def hpoint
      point + (normalv * Float::EPSILON)
    end
  end
end
