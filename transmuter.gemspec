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

  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  # Run-time dependencies
  s.add_dependency 'i18n', '~>0.8.1'
  s.add_dependency 'activesupport', '~>5.1.1'
  s.add_dependency 'thor', '~>0.19.4'
  s.add_dependency 'pdfkit', '~>0.8.2'
  s.add_dependency 'redcarpet', '~>1.17.2' # TODO '~>3.4.0'
  s.add_dependency 'RedCloth', '~>4.3.2'
  s.add_dependency 'pygments.rb', '~>1.1.2'
  s.add_dependency 'nokogiri', '~>1.7.2'

  # Development dependencies
  s.add_development_dependency 'guard', '~>2.14.1'
  s.add_development_dependency 'guard-bundler', '~>2.1.0'
  s.add_development_dependency 'guard-rspec', '~>4.7.3'

  # Development / Test dependencies
  s.add_development_dependency 'rspec', '~>3.6.0'
  s.add_development_dependency 'its', '~>0.2.0'
  s.add_development_dependency 'mocha', '~>1.2.1'

  # Debugging
  s.add_development_dependency 'pry', '~>0.10.4'
end
