# frozen_string_literal: true

module Ra
  module Pattern
    # An abstract pattern. Any concrete subclass of pattern must implement the
    # method `local_color`.
    class Base
      attr_accessor :transform

      # @param transform [Ra::Matrix]
      def initialize(transform: Transform::IDENTITY)
        @transform = transform
      end

      # @param point [Vector]
      # @return [Ra::Color]
      def color(point:)
        local_point = transform.inverse * point
        local_color(local_point:)
      end

      protected

      # @param local_point [Vector]
      # @return [Ra::Color]
      def local_color(local_point:)
        raise NotImplementedError, '#local_color must be implemented by a concrete subclass'
      end
    end
  end
end
