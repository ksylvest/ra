# frozen_string_literal: true

module Ra
  # A logger used to make exe testing possible.
  #
  #   logger = Logger.new
  #   logger.log("Greetings!")
  class Logger
    # @param stream [IO]
    def initialize(stream: $stdout)
      @stream = stream
    end

    # @param message [String]
    def log(message = nil)
      @stream.puts message
    end
  end
end
