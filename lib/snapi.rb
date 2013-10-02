# include all the things!
require "snapi/capabilities/errors"
require "snapi/validator"
require "snapi/capabilities/argument"
require "snapi/capabilities/function"
require "snapi/capability"


module Snapi
  @@capabilities = {}

  def self.capabilities
    @@capabilities
  end

  def self.register_capability(klass)
    @@capabilities[klass.namespace] = klass
  end
end
