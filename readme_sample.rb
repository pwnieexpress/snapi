require 'snapi'

class SayHello
  include Snapi::Capability
  function :hello_world

  def self.hello_world(params)
    puts "Hello World"
  end
end

require 'pry'
binding.pry
