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

module Snapi
  module SinatraExtension
    extend Sinatra::Extension

    get "/?" do
      JSON.generate(Snapi.capabilities)
    end

    # TODO actually use Sinatra::Namespace
    Snapi.capabilities.each do |slug,klass|
      base_path = "/#{slug.to_s}"
      get "#{base_path}/?" do
        JSON.generate(klass.to_hash)
      end

      klass.functions.each do |fn,_|
        get "#{base_path}/#{fn.to_s}/?" do
          klass.run_function(fn,params)
        end
      end
    end
  end
end

class AwwwwwwwwwSnap < Sinatra::Base
  register Sinatra::Namespace

  get '/' do
    "SNAPI SAMPLE APP DAWG"
  end

  namespace Snapi.capability_root do
    register Snapi::SinatraExtension
  end

  run! if app_file == $0
end
