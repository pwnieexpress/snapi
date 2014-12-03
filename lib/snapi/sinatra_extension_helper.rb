require 'digest/sha2'

module Snapi
  module SinatraExtensionHelper
    # Helper that handles wrapping all API data requests in a standard format
    # that includes status and error messages (if there were any).
    #
    # @param data [Hash] Singular or multiple data objects the client
    #   requested, should include a JSON schema attribute to allow for response
    #   validation.
    # @param response_code [Fixnum] HTTP Status code to return
    # @param errors [Array<String>] List of errors that occured while processing
    #   the request.
    def response_wrapper(data = {}, response_code = 200, errors = [])
      time_taken = nil

      if block_given?
        time_start = Time.now

        begin
          data = data.deep_merge(yield)
        rescue Exception => e
          response_code = 500
          errors << "#{e.class.name}: #{e.backtrace.first}"
        end

        time_end = Time.now
        time_taken = (time_end - time_start)
      end

      response = { status: response_code, data: data }
      response[:errors] = errors unless errors.empty?
      response[:execution_time] = time_taken unless time_taken.nil?

      # Use halt to prevent all further processing
      halt(response_code, response.to_json)
    end
  end
end
