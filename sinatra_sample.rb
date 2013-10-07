require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'json'
require 'snapi'

module Snapi
  PLUGIN_ROOT = "/plugins/?"

  module SinatraPlugin
    extend Sinatra::Extension

    get PLUGIN_ROOT do
      JSON.generate(Snapi.capabilities)
    end
  end
end

class Snapppppp < Sinatra::Base
  register Snapi::SinatraPlugin
  get '/' do
    "SNAPI SAMPLE APP DAWG"
  end

  run! if app_file == $0
end
