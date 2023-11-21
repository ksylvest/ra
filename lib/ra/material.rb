# frozen_string_literal: true

module Ra
  # A material is used to define the properties of an object that impact the color applied. For example:
  #
  #   material = Ra::Material.new(
  #    color: Ra::Color.uniform(0.5),
  #    ambient: 0.2,
  #    diffuse: 0.5,
  #    specular: 0.7,
  #    shininess: 200,
  #   )
  class Material
    attr_accessor :base, :ambient, :diffuse, :specular, :shininess

    # @param color [Ra::Color]
    # @param ambient [Float] between 0.0 and 1.0
    # @param diffuse [Float] between 0.0 and 1.0
    # @param specular [Float] between 0.0 and 1.0
    # @param shininess [Numeric]
    def initialize(color:, ambient: 0.2, diffuse: 0.6, specular: 0.6, shininess: 200)
      @color = color
      @ambient = ambient
      @diffuse = diffuse
      @specular = specular
      @shininess = shininess
    end
  end
end
