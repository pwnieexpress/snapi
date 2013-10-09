# include all the things!
require "snapi/validator"
require "snapi/errors"
require "snapi/argument"
require "snapi/function"
require "snapi/capability"

module Snapi
  @@capabilities = {}

  def self.capabilities
    @@capabilities || {}
  end

  def self.register_capability(klass)
    @@capabilities[klass.namespace] = klass
  end

  def self.valid_capabilities
    @@capabilities.keys
  end

  def self.capability_root
    # todo make this configurable
    "/plugins/?"
  end
end

# This depends on Snapi module being defined as above
require "snapi/sinatra_extension"

