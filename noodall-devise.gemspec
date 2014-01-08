# -*- encoding: utf-8 -*-
require File.expand_path("../lib/noodall/devise/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "noodall-devise"
  s.version     = Noodall::Devise::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve England"]
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/noodall-components-gallery"
  s.summary     = "Noodall Devise: User sign in and managent with devise"
  s.description = "User sign in and managent with devise. Provides administration of users in the admin area"

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency 'devise', '~> 2.2.5'
  s.add_dependency 'mm-devise', '~> 2.0'
  s.add_dependency 'noodall-ui', ">= 0.4.1"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
