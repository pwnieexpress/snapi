require 'json'
require 'sinatra/contrib'

module Snapi
  # TODO document, test, make more robust
  module SinatraExtension
    extend Sinatra::Extension

    get "/?" do
      JSON.generate(Snapi.capabilities)
    end

    # TODO use Sinatra::Namespace?
    Snapi.capabilities.each do |slug,klass|
      require 'pry'
      binding.pry
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
