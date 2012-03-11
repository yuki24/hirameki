# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hirameki/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Yuki Nishijima"]
  gem.email         = ["mail@yukinishijima.net"]
  gem.description   = %q{redis based one time token generator.}
  gem.summary       = %q{redis based one time token generator.}
  gem.homepage      = "https://github.com/yuki24/hirameki"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "hirameki"
  gem.require_paths = ["lib"]
  gem.version       = Hirameki::VERSION
end
