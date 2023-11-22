# frozen_string_literal: true

require 'matrix'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

# Named for ["Ra"](https://en.wikipedia.org/wiki/Ra).
module Ra
  EPSILON = (2**-16)

  # @return [Ra::Logger]
  def self.logger
    @logger ||= Logger.new
  end
end
