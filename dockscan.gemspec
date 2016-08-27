# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dockscan/version'

Gem::Specification.new do |spec|
  spec.name          = "dockscan"
  spec.version       = Dockscan::VERSION
  spec.authors       = ["Vlatko Kosturjak"]
  spec.email         = ["kost@linux.hr"]

  spec.summary       = %q{Security vulnerability and audit scanner for Docker installations.}
  spec.description   = %q{security vulnerability and audit scanner for Docker installations.}
  spec.homepage      = "https://github.com/kost/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
