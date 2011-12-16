# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transmuter/version"

Gem::Specification.new do |s|
  s.name        = "transmuter"
  s.version     = Transmuter::VERSION
  s.authors     = ["Wael Nasreddine"]
  s.email       = ["wael.nasreddine@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{The Alien device to convert Markdown and Textile files to HTML or PDF.}
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  # Run-time dependencies
  s.add_dependency 'i18n', '~>0.6.0'
  s.add_dependency 'activesupport', '~>3.1.0'
  s.add_dependency 'thor', '~>0.14.6'
  s.add_dependency 'pdfkit', '~>0.5.2'
  s.add_dependency 'redcarpet', '~>1.17.2'
  s.add_dependency 'RedCloth', '~>4.2.8'
  s.add_dependency 'pygments.rb', '~>0.2.4'
  s.add_dependency 'nokogiri', '~>1.5.0'

  # Development dependencies
  s.add_development_dependency 'guard', '~>0.8.4'
  s.add_development_dependency 'guard-bundler', '~>0.1.3'
  s.add_development_dependency 'guard-rspec', '~>0.4.5'

  # Development / Test dependencies
  s.add_development_dependency 'rspec', '~>2.6.0'
  s.add_development_dependency 'mocha', '~>0.10.0'

  # Debugging
  s.add_development_dependency 'pry', '~>0.9.6.2'
end