# frozen_string_literal: true

module Ra
  # A surface contains everything needed to apply lighting.
  class Surface
    # @!attribute eyev
    #   @return [Vector]
    attr_accessor :eyev

    # @!attribute normalv
    #   @return [Vector]
    attr_accessor :normalv

    # @!attribute reflectv
    #   @return [Vector]
    attr_accessor :reflectv

    # @!attribute shape
    #   @return [Ra::Shape]
    attr_accessor :shape

    # @!attribute point
    #   @return [Vector]
    attr_accessor :point

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
