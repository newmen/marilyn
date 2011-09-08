# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "marilyn/version"

Gem::Specification.new do |s|
  s.name        = "marilyn"
  s.version     = Marilyn::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gleb Averchuk"]
  s.email       = ["altermn@gmail.com"]
  s.homepage    = "https://github.com/newmen/marilyn"
  s.summary     = %q{Provides a good templates.}
  s.description = %q{Provides a good templates for the generators instead of the Rails standard, as well as some minimal required files.}

  s.rubyforge_project = "marilyn"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'cancan'
  s.add_dependency 'devise'
  #s.add_dependency 'jquery-rails'
  s.add_dependency 'railties', '>= 3.1.0'

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
