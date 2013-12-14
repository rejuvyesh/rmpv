# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rmpv/version'

Gem::Specification.new do |spec|
  spec.name          = "rmpv"
  spec.version       = Rmpv::VERSION
  spec.authors       = ["rejuvyesh"]
  spec.email         = ["mail@rejuvyesh.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "https://rejuvyesh.com/rmpv"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # core dependencies
  spec.add_runtime_dependency "traktr", "~> 0"

  # development dependencies
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
