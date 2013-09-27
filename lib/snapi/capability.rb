module Snapi
  class Capability
    class << self
      attr_accessor :functions, :library_class
    end

    def self.functions
      @functions || {}
    end

    def self.library_class
      @library_class || self
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

    def self.library(klass=self)
      @library_class = klass
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

    def self.valid_library_class?
      self.functions.keys.each do |function_name|
        return false unless self.library_class.methods.include?(function_name)
      end
      true
    end
  end
end
