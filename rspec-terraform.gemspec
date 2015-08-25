# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-terraform/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-terraform'
  spec.version       = RSpec::Terraform::VERSION
  spec.authors       = ['Ben Snape']
  spec.email         = ['bsnape@gmail.com']

  spec.summary       = %q{RSpec test fixtures for Terraform modules.}
  spec.homepage      = 'https://github.com/bsnape/rspec-terraform'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
end
