# frozen_string_literal: true

module Ra
  module Pattern
    # An abstract pattern. Any concrete subclass of pattern must implement the method `color`.
    class Base
      # @param point [Vector] <u = 0.0..1.0, v = 0.0..1.0>
      # @return [Ra::Color]
      def color(point:)
        raise NotImplementedError, '#color must be implemented by a concrete subclass'
      end
    end
  end
end
