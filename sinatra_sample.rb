require 'rubygems'
require 'sinatra'
require 'snapi'

class Snapppppp < Sinatra::Base
  get '/' do
    "SNAPI SAMPLE APP DAWG"
  end

  run! if app_file == $0
end
