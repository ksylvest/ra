# frozen_string_literal: true

module Ra
  # A transform is represnted with a four by four matrix. These transforms are useful manupulate vectors. For example:
  #
  #   p = Vector[1, 2, 3, Ra::Tuple::POINT]
  #   Ra::Transform.translate(2, 3, 4) * p == Vector[3, 5, 7, Ra::Tupl::POINT]
  #   Ra::Transform.scale(1, 2, 3) * p == Vector[1, 4, 9, Ra::Tuple::POINT]
  #
  # As a convenience, transforms can also be chained:
  #
  #   Ra::Transform
  #     .translate(2, 3, 4)
  #     .scale(1, 2, 3)
  #     .rotate_x(Math::PI / 4)
  #     .rotate_y(Math::PI / 4)
  #     .rotate_z(Math::PI / 4)
  class Transform < ::Matrix
    IDENTITY = identity(4)

    # @param from [Vector]
    # @param to [Vector]
    # @param up [Vector]
    # @return [Ra::Transform]
    def self.view(from:, to:, up:)
      f = (to - from).normalize
      l = Tuple.cross(f, up.normalize)
      u = Tuple.cross(l, f)

      self[l, u, -f, [0, 0, 0, 1]]
        .translate(-from[0], -from[1], -from[2])
    end

    # @return [Ra::Transform]
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric]
    def self.translate(x, y, z)
      self[
        [1, 0, 0, x],
        [0, 1, 0, y],
        [0, 0, 1, z],
        [0, 0, 0, 1],
      ]
    end

    # @return [Ra::Transform]
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric]
    def self.scale(x, y, z)
      self[
        [x, 0, 0, 0],
        [0, y, 0, 0],
        [0, 0, z, 0],
        [0, 0, 0, 1],
      ]
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def self.rotate_x(rotation)
      self[
        [1, 0, 0, 0],
        [0, +Math.cos(rotation), -Math.sin(rotation), 0],
        [0, +Math.sin(rotation), +Math.cos(rotation), 0],
        [0, 0, 0, 1],
      ]
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def self.rotate_y(rotation)
      self[
        [+Math.cos(rotation), 0, +Math.sin(rotation), 0],
        [0, 1, 0, 0],
        [-Math.sin(rotation), 0, +Math.cos(rotation), 0],
        [0, 0, 0, 1],
      ]
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def self.rotate_z(rotation)
      self[
        [+Math.cos(rotation), -Math.sin(rotation), 0, 0],
        [+Math.sin(rotation), +Math.cos(rotation), 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
      ]
    end

    # @return [Ra::Transform]
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric]
    def translate(...)
      self * self.class.translate(...)
    end

    # @return [Ra::Transform]
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric]
    def scale(...)
      self * self.class.scale(...)
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def rotate_x(...)
      self * self.class.rotate_x(...)
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def rotate_y(...)
      self * self.class.rotate_y(...)
    end

    # @return [Ra::Transform]
    # @param rotation [Numeric]
    def rotate_z(...)
      self * self.class.rotate_z(...)
    end

    # Avoid re-computing a transform inverse by memoizing.
    #
    # @return [Ra::Transform]
    def inverse
      @inverse ||= super
    end

    # Avoid re-computing a transform tranpose by memoizing.
    #
    # @return [Ra::Transform]
    def tranpose
      @tranpose ||= super
    end
  end
end
