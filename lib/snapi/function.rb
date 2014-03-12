module Snapi
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
      args =  []
      arguments.each { |k,v| args <<  {name: k }.merge(v.attributes) } if arguments
      { return_type: return_type, arguments: args }
    end

    # This method accepts a hash (as from a web request) which it
    # uses to compare against its argument definitions in order to
    # do some upfront validation before trying to run the function
    # names as defined in the library_class
    #
    # TODO: build up an errors hash to disclose what the issue is
    #
    # @params args Hash
    # @returns Boolean
    def valid_args?(args={})
      valid = false

      if arguments
        arguments.each do |name, argument|
          if argument[:required]
            return false if args[name] == nil
          end

          if argument[:default_value] && !args[name]
            args[name] = argument[:default_value]
          end

          valid = argument.valid_input?(args[name])
        end
      else
        valid = true
      end

      return valid
    end
  end
end
