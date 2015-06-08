# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poto/version'

Gem::Specification.new do |spec|
  spec.name          = "poto"
  spec.version       = Poto::VERSION
  spec.authors       = ["James Moriarty"]
  spec.email         = ["james.moriarty@rea-group.com"]

  spec.summary       = %q{AWS S3 image gallery.}
  spec.homepage      = "https://github.com/jamesmoriarty/poto"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "sinatra",          "~> 1"
  spec.add_dependency "grape",            "~> 0.11"
  spec.add_dependency "roar",             "~> 1"
  spec.add_dependency "grape-roar",       "~> 0.3"
  spec.add_dependency "rack-hal_browser", "~> 0.3"
  spec.add_dependency "hal-index",        "~> 0.0.9"
  spec.add_dependency "aws-sdk",          "~> 2"
end
