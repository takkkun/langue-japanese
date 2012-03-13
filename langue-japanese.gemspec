# -*- encoding: utf-8 -*-
require File.expand_path('../lib/langue/japanese/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Takahiro Kondo"]
  gem.email         = ["kondo@atedesign.net"]
  gem.description   = %q{It provides the operations to Japanese.}
  gem.summary       = %q{The foundation for Japanese}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "langue-japanese"
  gem.require_paths = ["lib"]
  gem.version       = Langue::Japanese::VERSION

  # gem.add_runtime_dependency 'langue'
  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'autotest'
  gem.add_development_dependency 'autotest-fsevent'
  gem.add_development_dependency 'autotest-growl'
end
