# frozen_string_literal: true

module Ra
  # Lighting encaspulates a [Phong Reflection Model](https://en.wikipedia.org/wiki/phong_reflection_model).
  class Lighting
    attr_accessor :light, :surface, :shadowed

    # @param light [Ra::Light]
    # @param surface [Ra::Surface]
    # @param shadowed [Boolean]
    def initialize(light:, surface:, shadowed:)
      @surface = surface
      @shadowed = shadowed
      @light = light
    end

    # @param shadowed [Boolean]
    # @return [Ra::Color]
    def color
      ambient_color + diffuse_color + specular_color
    end

    private

    # @param [Ra::Shape]
    def shape
      surface.shape
    end

    # @return [Vector]
    def point
      surface.point
    end

    # @return [Vector]
    def normalv
      surface.normalv
    end

    # @return [Vector]
    def eyev
      surface.eyev
    end

    # @return [Ra::Material]
    def material
      shape.material
    end

    # @return [Ra::Vector]
    def lightv
      @lightv ||= (light.position - point).normalize
    end

    # @return [Ra::Vector]
    def reflectv
      @reflectv ||= -(lightv - (normalv * 2 * lightv.dot(normalv)))
    end

    # @return [Ra::Vector]
    def light_dot_normal
      @light_dot_normal ||= lightv.dot(normalv)
    end

    # @return [Ra::Vector]
    def reflect_dot_eye
      @reflect_dot_eye ||= reflectv.dot(eyev)
    end

    # @return [Ra::Color]
    def ambient_color
      @ambient_color ||= effective_color * material.ambient
    end

    # @return [Ra::Color, nil]
    def diffuse_color
      return if shadowed
      return if light_dot_normal.negative?

      @diffuse_color ||= effective_color * material.diffuse * light_dot_normal
    end

    # @return [Ra::Color, nil]
    def specular_color
      return if shadowed
      return if light_dot_normal.negative?
      return unless reflect_dot_eye.positive?

      @specular_color ||= light.intensity * material.specular * (reflect_dot_eye**material.shininess)
    end

    # @return [Ra::Color]
    def effective_color
      @effective_color ||= shape.color(point:) * light.intensity
    end
  end
end
