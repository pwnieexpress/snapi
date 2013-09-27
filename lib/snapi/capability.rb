module Snapi
  class Capability
    class << self
      attr_accessor :functions
    end

    def functions
      @functions || {}
    end

    def self.function(name)
      fn = Capabilities::Function.new

      raise InvalidFunctionNameError unless Validator.valid_input?(:snapi_function_name, name)

      if block_given?
        yield(fn)
      end
      @functions ||= {}
      @functions[name] = fn.to_hash
    end

    # Convert the class name to a snake-cased
    # symbol namespace
    def self.namespace
      self.name
          .split('::').last
          .scan(/([A-Z]+[a-z0-9]+)/)
          .flatten.map(&:downcase)
          .join("_")
          .to_sym
    end

    def self.to_hash
      {
        self.namespace => self.functions
      }
    end

    def self.full_hash
      self.subclasses.inject({}) do |collector, klass|
        collector.merge(klass.to_hash)
      end
    end
  end
end
