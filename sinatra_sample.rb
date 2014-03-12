require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'snapi'

module Villains
  class Gunther
    def self.kidnap(args={})
      "AHAHAHA!!! GOT THE PRINCESS!!! #{ args[:princess].upcase } I JUST WANT A DATE"
    end

    def self.ice_attack(args={})
      "HAHA ICE ATTACK!"
    end
  end

  class IceKing
    include Snapi::Capability

    function :kidnap do |fn|
      fn.argument :princess do |arg|
        arg.required true
        arg.type :string
      end
      fn.return :raw
    end

    function :ice_attack do |fn|
      fn.return :raw
    end

    library Gunther
  end
end

module Heroes
  class FinnTheHuman
    include Snapi::Capability
    function :rescue do |fn|
      fn.argument :princess do |arg|
        arg.required true
        arg.type :string
      end
      fn.return :raw
    end

    def self.rescue(args={})
      "GODDAMNIT ICEKING! GIVE BACK #{ args[:princess].upcase }!!"
    end
  end
end

class AwwwwwwwwwSnap < Sinatra::Base
  register Sinatra::Namespace

  get '/' do
    "SNAPI SAMPLE APP DAWG"
  end

  namespace '/plugins' do
    register Snapi::SinatraExtension
  end

  run! if app_file == $0
end
