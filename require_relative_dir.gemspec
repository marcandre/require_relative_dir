# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'require_relative_dir/version'

Gem::Specification.new do |spec|
  spec.name          = 'require_relative_dir'
  spec.version       = RequireRelativeDir::VERSION
  spec.authors       = ['Marc-Andre Lafortune']
  spec.email         = ['github@marc-andre.ca']

  spec.summary       = 'Basic utility to require a directory.'
  spec.description   = 'Basic utility to require a directory.'
  spec.homepage      = 'https://github.com/marcandre/require_relative_dir'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '> 2.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
