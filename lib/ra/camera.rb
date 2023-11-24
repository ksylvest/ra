# frozen_string_literal: true

module Ra
  # A camera produces rays used to generate pixels. By convention, the camera
  # is positioned at the point <x=0,y=0,z=0>. The rays target an imaginary
  # screen that exists at z=-1. The x,y values visible on the screen depend on
  # the FOV and the width / height of the desired image.
  #
  # A FOV represents the angel of the world visible to the camera. A default
  # FOV is 90 degrees. This results in 2.0 by 2.0 of the world visible at z=-1.
  #
  # A bigger FOV increases what in the world is visible to the camera. When FOV
  # is 120 degrees then ~3.5 by ~3.5 world view visible through z=-1.
  #
  # A smaller FOV decreases what in the world is visible to the camera. When FOV
  # is 60 degrees then ~1.2 by ~1.2 world view is visible through z=-1.
  #
  # The visible world view is then split into pixels bsaed on the l / w of the
  # desired screen. The pixel size is calculated using these l / w dimensions.
  # The pixels are defined to be evenly spaced within the visible world.
  #
  # An example of a default 90 degree FOV and w=5 / h=4 results in pixels that
  # are of size 0.4 (the greater of 2.0 / w=5 and 2.0 / h=4). With these
  # dimensions rays are cast to the center of pixels evenly distrubted across
  # the screen.
  class Camera
    include Enumerable

    attr_accessor :h, :w, :fov, :transform

    DEFAULT_W = 1280
    DEFAULT_H = 1024
    DEFAULT_FOV = Math::PI / 3

    # @param transform [Ra::Transform]
    # @param h [Numeric]
    # @param w [Numeric]
    # @param fov [Numeric]
    def initialize(transform: Transform::IDENTITY, h: DEFAULT_H, w: DEFAULT_W, fov: DEFAULT_FOV)
      @transform = transform
      @h = h
      @w = w
      @fov = fov
    end

    # @yield [y, x, ray] y, x, ray
    # @yieldparam [Integer] y
    # @yieldparam [Integer] x
    # @yieldparam [Ra::Ray] ray
    def each
      @h.times do |y|
        @w.times do |x|
          ray = ray(
            y:,
            x:,
          )
          yield(y, x, ray)
        end
      end
    end

    # @param x [Numeric]
    # @param y [Numeric]
    # @return [Ra::Ray]
    def ray(x:, y:)
      pixel = transform.inverse * Vector[world_x(x:), world_y(y:), -1, Tuple::POINT]
      origin = transform.inverse * Vector[0, 0, 0, Tuple::POINT]

      direction = (pixel - origin).normalize

      Ray.new(origin:, direction:)
    end

    # @return [Float]
    def p_size
      @p_size ||= half_w * 2 / w
    end

    # @return [Float]
    def half_view
      @half_view ||= Math.tan(@fov / 2)
    end

    # @return [Float]
    def half_w
      @half_w ||= @w < @h ? (half_view * @w / @h) : half_view
    end

    # @return [Float]
    def half_h
      @half_h ||= @h < @w ? (half_view * @h / @w) : half_view
    end

    private

    # @param y [Float]
    # @return [Float]
    def world_y(y:)
      offset_y = (y + 0.5) * p_size
      half_h - offset_y
    end

    # @param x [Float]
    # @return [Float]
    def world_x(x:)
      offset_x = (x + 0.5) * p_size
      half_w - offset_x
    end
  end
end
