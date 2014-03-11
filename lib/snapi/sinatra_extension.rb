require 'json'
require 'sinatra/contrib'

module Snapi
  module SinatraExtension
    extend Sinatra::Extension

    get "/?" do
      JSON.generate(Snapi.capability_hash)
    end

    get "/:capability/?" do
      @capability = params.delete("capability").to_sym

      if Snapi.has_capability?(@capability)
        JSON.generate(Snapi[@capability].to_hash)
      else
        # TODO: don't raise here...
        raise InvalidCapabilityError
      end
    end

    get "/:capability/:function/?" do
      @capability = params.delete("capability").to_sym
      @function   = params.delete("function").to_sym

      unless Snapi.has_capability?(@capability)
        # TODO: don't raise here...
        raise InvalidCapabilityError
      end

      unless Snapi[@capability].valid_function_call?(@function,params)
        # TODO: don't raise here...
        raise InvalidFunctionCallError
      end

      # TODO
      # TODO
      # TODO
      # Add response_wrapper which ensures that the return data from the
      # function matches the type declared in the capabilities function defitition
      # TODO
      # TODO
      # TODO
      response = Snapi[@capability].run_function(@function,params)
      response.class == String ? response : JSON.generate(response)
    end
  end
end
