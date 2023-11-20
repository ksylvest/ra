# frozen_string_literal: true

require_relative 'lib/ra/version'

Gem::Specification.new do |spec|
  spec.name = 'ra'
  spec.version = Ra::VERSION
  spec.authors = ['Kevin Sylvestre']
  spec.email = ['kevin@ksylvest.com']

  spec.summary = 'A graphics library written for fun.'
  spec.description = 'This should probably never be used for anything but learning.'
  spec.homepage = 'https://github.com/ksylvest/ra'
  spec.license = 'MIT'

  spec.files = Dir.glob('{exe,lib}/**/*') + %w[README.md]

  spec.bindir = 'exe'
  spec.executables = ['ra']

  spec.required_ruby_version = '>= 3.2'

  spec.require_paths = ['lib']

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'zeitwerk'
end
