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

  def self.capability_root
    "/plugins/?"
  end
end

# This depends on Snapi module being more
# robustly defined as above
require "snapi/sinatra_extension"
