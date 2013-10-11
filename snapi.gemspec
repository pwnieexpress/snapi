# Rake required to use FileList[].to_s as in s.files=() below
require 'rake'
require File.expand_path '../lib/snapi/version.rb', __FILE__

Gem::Specification.new do |s|
  s.name        = 'snapi'
  s.version     = Snapi::VERSION
  s.date        = '2013-10-09'
  s.summary     = "Snapi"
  s.description = "Modular Capability Disclosure DSL"
  s.homepage    = "https://github.com/pwnieexpress/snapi"
  s.authors     = ["Gabe Koss"]
  s.email       = "gabe@pwnieexpress.com"
  s.files       = FileList[ 'bin/**/*', 'lib/**/*', '[A-Z]*', 'spec/**/*' ].to_a
  s.license     = 'MIT'

  s.add_development_dependency('rspec')
end
