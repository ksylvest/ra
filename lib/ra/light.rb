# frozen_string_literal: true

module Ra
  # A light has a position within a scene and an intensity it is rendered
  # with. For example:
  #
  #   light = Ra::Light.new(
  #     intensity: Ra::Color.uniform(0.8),
  #     position: Vector[0, 0, 0, Ra::Tuple::POINT],
  #   )
  class Light
    # @!attribute intensity
    #   @return [Ra::Color]
    attr_accessor :intensity

    # @!attribute position
    #   @return [Vector]
    attr_accessor :position

    # @param intensity [Ra::Color]
    # @param position [Vector]
    def initialize(intensity:, position:)
      @intensity = intensity
      @position = position
    end
  end
end
