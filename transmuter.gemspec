# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transmuter/version"

Gem::Specification.new do |s|
  s.name        = "transmuter"
  s.version     = Transmuter::VERSION
  s.authors     = ["Wael Nasreddine"]
  s.email       = ["wael.nasreddine@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{convert markdown to HTML or PDF.}
  s.description = %q{convert markdown to HTML or PDF.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
