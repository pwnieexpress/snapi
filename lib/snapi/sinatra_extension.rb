require 'json'
require 'sinatra/contrib'

module Snapi
  module SinatraExtension
    extend Sinatra::Extension

    get "/?" do
      capabilities = Snapi.capabilities
      capabilities.keys.each do |key|
        capabilities[key] = capabilities[key].to_hash
      end
      JSON.generate(capabilities)
    end

    get "/:capability/?" do
      @capability = params.delete("capability").to_sym

      unless Snapi.valid_capabilities.include?(@capability)
        raise InvalidCapabilityError
      end

      JSON.generate(Snapi.capabilities[@capability].to_hash)
    end

    get "/:capability/:function/?" do
      @capability = params.delete("capability").to_sym
      @function   = params.delete("function").to_sym

      unless Snapi.valid_capabilities.include?(@capability)
        raise InvalidCapabilityError
      end

      unless Snapi.capabilities[@capability].valid_function_call?(@function,params)
        raise InvalidFunctionCallError
      end

      # TODO add response_wrapper which ensures that the return data from the
      # function matches the type declared in the capabilities function defitition
      response = Snapi.capabilities[@capability].run_function(@function,params)
      response.class == String ? response : JSON.generate(response)
    end

  end
end
