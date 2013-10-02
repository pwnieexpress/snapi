module Snapi
  # Arguments are an intrinsic part of Capability and Function declaration
  # in that Capabilities are made up of Functions and Functions may have
  # one or more Arguments defined for them.
  #
  # Arguments are a code representation of a meta-programming way of defining
  # what arguments or paramater SHOULD or MUST be passed to a method
  # which represents a function on the Capabilities library class
  class Argument

    # @attributes tracks the various meta-attributes which can be
    # set for the argument record.  This initializer simply sets that
    # value as
    def initialize
      @attributes = {}
    end

    # Allow the record to behave like a hash by giving access to @attributes
    # via [] getter
    #
    # @params key, key to query @attributes with
    def [](key)
      @attributes[key]
    end

    # Allow the record to behave like a hash by giving access to @attributes
    # via []= setter
    #
    # Validates the key requested to set is included in the valid_attributes
    # white list and then uses the uses the various setter methods below to
    # set the value.
    #
    # @param key, attribute name
    # @param value, value to set
    def []=(key, value)
      raise InvalidArgumentAttributeError unless valid_attributes.include?(key)
      send(key, value)
    end

    # Get the @attributes hash
    #
    # @returns Hash
    def attributes
      @attributes
    end

    # Whitelist of attribute names
    #
    # @returns Array of Symbols
    def valid_attributes
      [:default_value, :format, :list, :required, :type, :values]
    end

    # DSL Setter
    # Set a default value for the argument if one is not provided
    #
    # @param val, Value to use in case one isn't provided,
    def default_value(val)
      raise InvalidStringError unless val.class == String
      @attributes[:default_value] = val
    end

    # DSL Setter
    # Set a format the check string types against using the
    # format_types outlined in Snapi::Validator
    #
    # @param format, Symbol of format to match against
    def format(format)
      raise InvalidFormatError unless Validator.valid_regex_format?(format)
      @attributes[:format] = format
    end

    # DSL Setter
    # Is the argument a list of options? If true it will be assumed that
    # this argument will be an array of objects of the sort set as type
    #
    # @param bool, Boolean value
    def list(bool)
      raise InvalidBooleanError unless [true,false].include? bool
      @attributes[:list] = bool
    end

    # DSL Setter
    # Is the argument a required?
    #
    # @param bool, Boolean value
    def required(bool)
      raise InvalidBooleanError unless [true,false].include? bool
      @attributes[:required] = bool
    end

    # DSL Setter
    # What type of value is this argument. This will impact the way in which
    # this argument value gets validated later on
    #
    #  Valid types are: :boolean, :enum, :string, :number, :timestamp
    #
    # @param type, Symbol indicating type
    def type(type)
      valid_types = [:boolean, :enum, :string, :number, :timestamp]
      raise InvalidTypeError unless valid_types.include?(type)
      @attributes[:type] = type
    end

    # DSL Setter
    # What are the values that can be selected? This only applies to :enum typed arguments
    # and allow the argument to define a list of valid values to select from for this.
    #
    # In a form this would map to a select box. Alternative to using a :string argument
    # with a format to validate against.
    #
    # Basically creates a whitelist of values for this argument.
    #
    # @param values, Array
    def values(values)
      raise InvalidValuesError unless values.class == Array
      @attributes[:values] = values
    end

    # Check if a value provided will suffice for the way
    # this argument is defined.
    #
    # @param input, Just about anything...
    # @returns Boolean. true if valid
    def valid_input?(input)
      case @attributes[:type]
      when :boolean
        [true,false].include?(input)
      when :enum
        raise MissingValuesError unless @attributes[:values]
        raise InvalidValuesError unless @attributes[:values].class == Array

        @attributes[:values].include?(input)
      when :string
        format = @attributes[:format] || :anything
        Validator.valid_input?(format, input)
      when :number
        [Integer, Fixnum].include?(input.class)
      when :timestamp
        # TODO timestamp pending
        raise PendingBranchError
      else
        false
      end
    end
  end
end

