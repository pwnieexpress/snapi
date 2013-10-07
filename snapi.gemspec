# Rake required to use
# File.ist[].to_s as in s.files=() below
require 'rake'

Gem::Specification.new do |s|
  s.name        = 'snapi'
  s.version     = '0.0.2'
  s.date        = '2013-09-27'
  s.summary     = "Snapi"
  s.description = "Modular Capability Disclosure DSL"
  s.homepage    = "https://github.com/pwnieexpress/snapi"
  s.authors     = ["Gabe Koss"]
  s.email       = "gabe@pwnieexpress.com"
  s.files       = FileList[ 'bin/**/*', 'lib/**/*', '[A-Z]*', 'spec/**/*' ].to_a
  s.license     = 'MIT'

  s.add_development_dependency('rspec')
end
