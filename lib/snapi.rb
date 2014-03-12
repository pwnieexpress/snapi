# include all the things!
require "core_ext/hash"

require "snapi/validator"
require "snapi/errors"
require "snapi/argument"
require "snapi/function"
require "snapi/capability"
require "snapi/version"

module Snapi
  @@capabilities = {}

  def self.capabilities
    @@capabilities
  end

  def self.[](key)
    @@capabilities[key]
  end

  def self.register_capability(klass)
    @@capabilities[klass.namespace] = klass
  end

  def self.valid_capabilities
    @@capabilities.keys
  end

  def self.capability_hash
    valid_capabilities.each_with_object({}) do |cap,coll|
      coll[cap] = Snapi[cap].to_hash
    end
  end

  def self.has_capability?(capability)
    valid_capabilities.include?(capability)
  end
end

# This depends on Snapi module being defined as above
require "snapi/sinatra_extension_helper"
require "snapi/sinatra_extension"
