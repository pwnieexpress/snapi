require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'json'
require 'snapi'

module Villains
  class Gunther
    def self.kidnap(args={})
      "AHAHAHA!!! GOT THE PRINCESS!!! #{args[:princess].upcase} I JUST WANT A DATE"
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

    library Gunther
  end
end

module SinatraExtension
  extend Sinatra::Extension

  namespace Snapi.capability_root do
    get "/" do
      JSON.generate(Snapi.capabilities)
    end
  end
end

class AwwwwwwwwwSnap < Sinatra::Base
  register SinatraExtension

  get '/' do
    "SNAPI SAMPLE APP DAWG"
  end

  run! if app_file == $0
end
