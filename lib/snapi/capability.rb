module Snapi
  # This class is exists as a way of definining an API capability
  # using a handy DSL to define functions, their arguments, arity,
  # validations and return types.
  module Capability

    # When this module is included into a given Class
    # this will wbe run. It will extend the clas with
    # the methods found in the the Snapi::Capability::ClassMethods
    # module and register the class in question with the Snapi
    # module.
    #
    # @params klass, Class
    def self.included(klass)
      klass.extend(ClassMethods)
      Snapi.register_capability(klass)
    end

    module ClassMethods
      # modify the class to track @functions and @library_class
      # at the class level
      class << self
        attr_accessor :functions, :library_class
      end

      # Getter to query the internally tracked list of supported
      # functions.
      #
      # @returns Hash, @functions or new Hash
      def functions
        @functions || {}
      end

      # Getter to query the class which is responsible for having
      # methods which map to the names of the functions.
      #
      # @returns Class, @library_class || self
      def library_class
        @library_class || self
      end

      # DSL setter to add a function to the @functions hash
      #
      # @params name, Name of function being defined
      # @params Block to modify function
      # @returns Hash of function data
      def function(name)
        raise InvalidFunctionNameError unless Validator.valid_input?(:snapi_function_name, name)
        fn = Function.new
        if block_given?
          yield(fn)
        end
        @functions ||= {}
        @functions[name] = fn
      end

      # DSL Setter to define the ruby class (or module) which
      # contains methods that should map to the function names
      # in the @functions hash
      #
      # @params klass, Class which default to self
      # @returns Class
      def library(klass=self)
        @library_class = klass
      end

      # Test if the set library class is valid based on mapping
      # the keys of the @functions hash against the methods available
      # to the @library_class
      #
      # @returns Boolean, true if @library_class offers all the methods needed
      def valid_library_class?
        self.functions.keys.each do |function_name|
          return false unless @library_class.methods.include?(function_name)
        end
        true
      end

      # Convert the class name to a snake-cased symbol namespace
      # representation of class name for use in namespacing
      #
      # @returns Symbol, snake_cased
      def namespace
        self.name
        .split('::').last
        .scan(/([A-Z]+[a-z0-9]+)/)
        .flatten.map(&:downcase)
        .join("_")
        .to_sym
      end

      # Helper to conver the class itself to a hash representation
      # including the functions hash keyed off the namespace
      #
      # @returns Hash
      def to_hash
        fn_hash = {}
        functions.each {|k,v| fn_hash[k] = v.to_hash } if functions
        {
          self.namespace => fn_hash
        }
      end

      # Helper to check if a function call to the capability would
      # be valid with the given arguments
      #
      # @param function Symbolic name to reference the function out of the @functions hash
      # @param args hash of arguments
      # @returns Boolean
      def valid_function_call?(function, args)
        return false unless functions[function]
        functions[function].valid_args?(args)
      end

      # Accepts arguments and sends the args to the library class
      # version of the function assuming that the function has been declared
      # and the library class also includes that function
      #
      # @param function Symbolic name to reference the function out of the @functions hash
      # @param args hash of arguments
      # @returns God only knows, my friend, God only know
      def run_function(function,args)
        raise InvalidFunctionCallError         unless valid_function_call?(function, args)
        raise LibraryClassMissingFunctionError unless valid_library_class?
        library_class.send(function,args)
      end
    end
  end
end
