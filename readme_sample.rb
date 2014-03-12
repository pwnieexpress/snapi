require 'snapi'

class SayHello
  include Snapi::Capability

  function :hello_world

  def self.hello_world(params)
    "Hello World"
  end

  function :hello do |fn|
    fn.argument :friend do |arg|
      arg.required true
      arg.type :string
    end
  end

  def self.hello(params)
    "Hello #{params[:friend]}"
  end

end

class MyAPi < Sinatra::Base
  register Sinatra::Namespace

  namespace "/snapi" do
    register Snapi::SinatraExtension
  end

  run! if app_file == $0
end
