# frozen_string_literal: true

module Ra
  # A material is used to define the properties of an object that impact the color applied. For example:
  #
  #   material = Ra::Material.new(
  #    base: Ra::Color.uniform(0.5),
  #    ambient: 0.2,
  #    diffuse: 0.5,
  #    specular: 0.7,
  #    shininess: 200,
  #   )
  class Material
    attr_accessor :base, :ambient, :diffuse, :specular, :shininess

    # @param base [Ra::Color, Ra::Pattern:::Base]
    # @param ambient [Float] between 0.0 and 1.0
    # @param diffuse [Float] between 0.0 and 1.0
    # @param specular [Float] between 0.0 and 1.0
    # @param shininess [Numeric]
    def initialize(base:, ambient: 0.0, diffuse: 0.8, specular: 0.2, shininess: 80)
      @base = base
      @ambient = ambient
      @diffuse = diffuse
      @specular = specular
      @shininess = shininess
    end

    # @param point [Vector]
    # @return [Ra::Color]
    def color(point:)
      return base if base.is_a?(Color)

      base.color(point:)
    end
  end
end
