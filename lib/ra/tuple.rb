# frozen_string_literal: true

module Ra
  # A Tuple can classify a Vector as a POINT or VECTOR. For example:
  #
  #   point = Vector[x = 1, y = 2, z = 3, w = Ra::Tuple::POINT]
  #   vector = Vector[x = 1, y = 2, z = 3, w = Ra::Tuple::VECTOR]
  module Tuple
    POINT = 1
    VECTOR = 0

    # @param source [Vector]
    # @param target [Vector]
    # @return [Vector]
    def self.cross(source, target)
      cross = Vector[source[0], source[1], source[2]].cross(Vector[target[0], target[1], target[2]])

      Vector[
        cross[0],
        cross[1],
        cross[2],
        Tuple::VECTOR,
      ]
    end

    # @param vector [Vector]
    # @param normal [Vector]
    # @return [Vector]
    def self.reflect(vector, normal)
      vector - (normal * 2 * vector.dot(normal))
    end
  end
end
