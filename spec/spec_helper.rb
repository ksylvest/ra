# frozen_string_literal: true

require 'debug'
require 'simplecov'
require 'ra'

SimpleCov.start do
  enable_coverage :branch
end

Dir["#{__dir__}/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
