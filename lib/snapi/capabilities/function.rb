module Snapi
  module Capabilities

    # Functions are a core part of capability declaration as a
    # capability is basically a collection of functions.
    #
    # Functions take arguments and return a pre-defined type of
    # data structure.
    #
    # Right now Functions are structs which accept arguments
    # and return_type messages as well as a few DSL methods
    # to help define them dynamically
    #
    Function = Struct.new(:arguments, :return_type ) do


      # DSL setter to define a the meta information for an
      # argument for the Function
      #
      # Yields the argument to a given block for nice defition
      #
      # @params name
      def argument(name)
        arg = Argument.new
        if block_given?
          yield(arg)
        end
        self.arguments = {} if self.arguments == nil
        self.arguments[name] = arg
      end

      # DSL Setter to define the type of data returned by this function
      #
      # TODO currently allows types of 'none', 'raw' or 'structured' but
      # should support 'structured[stucture_type']
      #
      # @params type of returned data
      def return(type)
        valid = %w{ none raw structured }.include? type.to_s
        raise InvalidReturnTypeError unless valid

        self.return_type = type
      end

      # Hash representation of function including argument meta-data
      # as a hash.
      #
      # @returns Hash representation of Function
      def to_hash
        { return_type: return_type }.merge (arguments||{})
      end

    end
  end
end
