# frozen_string_literal: true

module Ra
  # A solver for all things quadratic. Given the equation:
  #
  #   ax² + bx +c = 0
  #
  # The solution for `x`` can be found via:
  #
  #   (-b ± √(b² - 4ac)) / (2a)
  #
  # No solution is defined when the discriminant (`b² - 4ac`) is negative or `a` is zero.
  module Quadratic
    # (-b ± √(b² - 4ac)) / (2a)
    #
    # @param a [Numeric]
    # @param b [Numeric]
    # @param c [Numeric]
    # @return [Array<Numeric>]
    def self.solve(a:, b:, c:)
      return [] if a.zero?

      discriminant = (b**2) - (4 * a * c)
      return [] if discriminant.negative?

      [
        (-b - Math.sqrt(discriminant)) / (2 * a),
        (-b + Math.sqrt(discriminant)) / (2 * a),
      ]
    end
  end
end
