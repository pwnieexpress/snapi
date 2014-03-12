require 'json'
require 'sinatra/contrib'

module Snapi
  module SinatraExtension

    extend Sinatra::Extension

    helpers Snapi::SinatraExtensionHelper

    # Hello darkness, my old friend
    def self.get_or_post(url,&block)
      get(url,&block)
      post(url,&block)
    end

    get_or_post "/?" do
      response_wrapper do
        Snapi.capability_hash
      end
    end

    get_or_post "/:capability/?" do
      @capability = params.delete("capability").to_sym

      response_wrapper do
        if Snapi.has_capability?(@capability)
          Snapi[@capability].to_hash
        else
          raise InvalidCapabilityError
        end
      end
    end

    get_or_post "/:capability/:function/?" do
      @capability = params.delete("capability").to_sym
      @function   = params.delete("function").to_sym

      response_wrapper do
        unless Snapi.has_capability?(@capability)
          raise InvalidCapabilityError
        end

        unless Snapi[@capability].valid_function_call?(@function,params)
          raise InvalidFunctionCallError
        end

        response = Snapi[@capability].run_function(@function,params)

        unless response.class == Hash
          response = { result: response }
        end

        response
      end
    end
  end
end
