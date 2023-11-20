# frozen_string_literal: true

module Ra
  # A Tuple can classify a Vector as a POINT or VECTOR. For example:
  #
  #   point = Vector[x = 1, y = 2, z = 3, w = Ra::Tuple::POINT]
  #   vector = Vector[x = 1, y = 2, z = 3, w = Ra::Tuple::VECTOR]
  module Tuple
    POINT = 1
    VECTOR = 0
  end
end
