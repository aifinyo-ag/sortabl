# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sortabl/version'

Gem::Specification.new do |spec|

  spec.name          = "sortabl"
  spec.version       = Sortabl::VERSION
  spec.authors       = ["Frederic Walch"]
  spec.email         = ["frederic.walch@informatik.hu-berlin.de"]

  spec.summary       = "Active Record plugin which helps and simplify sorting tables."
  spec.description   = "Check github repository for more in-depth information."
  spec.homepage      = "https://github.com/freder1c/sortabl"
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  spec.test_files    = Dir["test/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0", "~> 5.0"
  spec.add_dependency "activesupport", ">= 4.0", "~> 5.0"
  spec.add_dependency "actionview", ">= 4.0", "~> 5.0"

  spec.add_development_dependency "bundler", ">= 1.11"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", ">= 3.0"

end
