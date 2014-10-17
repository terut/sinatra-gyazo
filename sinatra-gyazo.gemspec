# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/gyazo/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-gyazo"
  spec.version       = Sinatra::Gyazo::VERSION
  spec.authors       = ["terut"]
  spec.email         = ["terut.dev+github@gmail.com"]
  spec.summary       = %q{Add Gyazo to sinatara.}
  spec.description   = %q{Add Gyazo to sinatara.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 1.4.5"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
