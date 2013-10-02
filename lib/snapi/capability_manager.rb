module Snapi
  module CapabilityManager

    @@capabilities = {}

    def self.capabilities
      @@capabilities
    end

    def self.register_capability(klass)
      @@capabilities[klass.namespace] = klass
    end

  end
end

