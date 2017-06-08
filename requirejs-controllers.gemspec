# -*- encoding: utf-8 -*-
require File.expand_path('../lib/requirejs/controllers/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "requirejs-controllers"
  gem.version       = Requirejs::Controllers::Rails::VERSION
  gem.authors       = ["Benedikt Böhm"]
  gem.email         = ["benedikt.boehm@madvertise.com"]
  gem.description   = %q{A collection of RequireJS controllers for Rails 3.x}
  gem.summary       = %q{A collection of RequireJS controllers for Rails 3.x}
  gem.homepage      = "https://github.com/madvertise/requirejs-controllers"

  gem.add_dependency "railties", "~> 4.2"

  gem.add_dependency "coffee-rails"
  gem.add_dependency "jquery-plugins-rails"
  gem.add_dependency "requirejs-rails"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end
