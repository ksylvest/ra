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
    # @!attribute r
    #   @return [Numeric]
    attr_accessor :r

    # @!attribute g
    #   @return [Numeric]
    attr_accessor :g

    # @!attribute b
    #   @return [Numeric]
    attr_accessor :b

    PRECISION = 255

    # @param value [Array<Numeric,Numeric,Numeric>]
    # @return [Ra::Color]
    def self.[](value)
      new(
        r: value[0],
        g: value[1],
        b: value[2],
      )
    end

    # @param value [String] e.g. "#336699"
    # @return [Ra::Color]
    def self.hex(value)
      r, g, b = value.match(/^#(..)(..)(..)$/).captures.map(&:hex)

      new(
        r: Float(r) / PRECISION,
        g: Float(g) / PRECISION,
        b: Float(b) / PRECISION,
      )
    end

    # @param value [Numeric] between 0.0 and 1.0
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

    # @param r [Numeric] between 0.0 and 1.0
    # @param g [Numeric] between 0.0 and 1.0
    # @param b [Numeric] between 0.0 and 1.0
    def initialize(r: 0.0, g: 0.0, b: 0.0)
      @r = r
      @g = g
      @b = b
    end

    # @param precision [Integer]
    # @return [Integer]
    def ppm(precision: PRECISION)
      "#{r_val(precision:)} #{g_val(precision:)} #{b_val(precision:)}"
    end

    # Combine the r / g / b components (+). If `other` is `nil` return `self`.
    #
    # @param other [Ra::Color, nil]
    # @return [Ra::Color]
    def +(other)
      return self if other.nil?

      self.class.new(r: r + other.r, g: g + other.g, b: b + other.b)
    end

    # Combine the r / g / b components (-). If `other` is `nil` return `self`.
    #
    # @param other [Ra::Color, nil]
    # @return [Ra::Color]
    def -(other)
      return self if other.nil?

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
    def r_val(precision: PRECISION)
      val(value: r, precision:)
    end

    # @return [Integer]
    def g_val(precision: PRECISION)
      val(value: g, precision:)
    end

    # @return [Integer]
    def b_val(precision: PRECISION)
      val(value: b, precision:)
    end

    private

    # @param value [Numeric]
    # @param precision [Integer]
    # @return [Integer]
    def val(value:, precision: PRECISION)
      (value * precision).clamp(0, precision).round
    end
  end
end
