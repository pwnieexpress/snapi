require 'rspec'
require 'pry'

require File.expand_path('../../lib/snapi.rb', __FILE__)

class Snapi::BasicCapability
  include Snapi::Capability
end
