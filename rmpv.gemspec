# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rmpv/version'

Gem::Specification.new do |spec|
  spec.name          = "rmpv"
  spec.version       = Rmpv::VERSION
  spec.authors       = ["rejuvyesh"]
  spec.email         = ["mail@rejuvyesh.com"]
  spec.description   = %q{Ruby wrapper for mpv}
  spec.summary       = %q{A ruby wrapper around mpv with trakt and myanimelist scobble support}
  spec.homepage      = "http://github.com/rejuvyesh/rmpv"
  spec.license       = "MIT"

  spec.rdoc_options     = ['--charset=UTF-8']
  spec.extra_rdoc_files = %w[README.md]
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "traktr"
  spec.add_dependency "toname"
end
