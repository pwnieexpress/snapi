require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require File.expand_path '../lib/snapi.rb', __FILE__

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
