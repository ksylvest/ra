# frozen_string_literal: true

module Ra
  # Color can be represented using r / g / b. Each component is assigned a
  # number between 0.0 and 1.0. A color can also be converted for use when
  # saving as [PPM](https://netpbm.sourceforge.net/doc/ppm.html).
  #
  #   color = Ra::Color.hex("#00FF00")
  #   color.r == 0.0
  #   color.g == 1.0
  #   color.b == 0.0
  #
  #   color = Ra::Color.new(
  #     r: 0.5,
  #     g: 0.7,
  #     b: 0.9,
  #   )
  #   color.ppm == "128 179 230"
  class Color
    attr_accessor :r, :g, :b

    DEFAULT_PRECISION = 255
    private_constant :DEFAULT_PRECISION

    # @param value [String] e.g. "#336699"
    # @return [Ra::Color]
    def self.hex(value)
      r, g, b = value.match(/^#(..)(..)(..)$/).captures.map(&:hex)

      new(
        r: Float(r) / DEFAULT_PRECISION,
        g: Float(g) / DEFAULT_PRECISION,
        b: Float(b) / DEFAULT_PRECISION,
      )
    end

    # @param value [Float] between 0.0 and 1.0
    # @return [Ra::Color]
    def self.uniform(value)
      new(r: value, g: value, b: value)
    end

    # @return [Ra::Color]
    def self.white
      @white ||= uniform(1.0)
    end

    # @return [Ra::Color]
    def self.black
      @black ||= uniform(0.0)
    end

    # @param r [Number] between 0.0 and 1.0
    # @param g [Number] between 0.0 and 1.0
    # @param b [Number] between 0.0 and 1.0
    def initialize(r: 0.0, g: 0.0, b: 0.0)
      @r = r
      @g = g
      @b = b
    end

    # @param precision [Integer]
    # @return [Integer]
    def ppm(precision: DEFAULT_PRECISION)
      "#{r_val(precision:)} #{g_val(precision:)} #{b_val(precision:)}"
    end

    # @param other [Ra::Color]
    # @return [Ra::Color]
    def +(other)
      self.class.new(r: r + other.r, g: g + other.g, b: b + other.b)
    end

    # @param other [Ra::Color]
    # @return [Ra::Color]
    def -(other)
      self.class.new(r: r - other.r, g: g - other.g, b: b - other.b)
    end

    # @param other [Ra::Color, Numeric]
    # @return [Ra::Color]
    def *(other)
      is_color = other.is_a?(self.class)
      other_r = is_color ? other.r : other
      other_g = is_color ? other.g : other
      other_b = is_color ? other.b : other

      self.class.new(
        r: r * other_r,
        g: g * other_g,
        b: b * other_b,
      )
    end

    # @param other [Ra::Color, Numeric]
    # @return [Ra::Color]
    def /(other)
      is_color = other.is_a?(self.class)
      other_r = is_color ? other.r : other
      other_g = is_color ? other.g : other
      other_b = is_color ? other.b : other

      self.class.new(
        r: r / other_r,
        g: g / other_g,
        b: b / other_b,
      )
    end

    # @return [Boolean]
    def ==(other)
      r_val == other.r_val && g_val == other.g_val && b_val == other.b_val
    end

    protected

    # @return [Integer]
    def r_val(precision: DEFAULT_PRECISION)
      val(value: r, precision:)
    end

    # @return [Integer]
    def g_val(precision: DEFAULT_PRECISION)
      val(value: g, precision:)
    end

    # @return [Integer]
    def b_val(precision: DEFAULT_PRECISION)
      val(value: b, precision:)
    end

    private

    # @param value [Float]
    # @param precision [Integer]
    # @return [Integer]
    def val(value:, precision: DEFAULT_PRECISION)
      (value * precision).clamp(0, precision).round
    end
  end
end
