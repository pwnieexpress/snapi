module Snapi
  module Capabilities
    # Arguments are an intrinsic part of Capability and Function declaration
    # in that Capabilities are made up of Functions and Functions may have
    # one or more Arguments defined for them.
    #
    # Arguments are a code representation of a meta-programming way of defining
    # what arguments or paramater SHOULD or MUST be passed to a method
    # which represents a function on the Capabilities library class
    class Argument

      # Each argument provides a hash of Attributes which
      # act as the object representation in the codebase.
      #
      # This hash should provide enough data to validate an input to the
      # function or build an HTML form element for the attribute.
      #
      # @returns Hash of attributes
      def attributes
        {
          :default_value => @default_value,
          :format => @format,
          :required => @required,
          :list => @list,
          :type => @type,
          :values => @values
        }
      end

      # DSL Setter
      # Set a default value for the argument if one is not provided
      #
      # @param val, Value to use in case one isn't provided,
      def default_value(val)
        raise InvalidStringError unless val.class == String
        @default_value = val
      end

      # DSL Setter
      # Set a format the check string types against using the
      # format_types outlined in Snapi::Validator
      #
      # @param format, Symbol of format to match against
      def format(format)
        raise InvalidFormatError unless Validator.valid_regex_format?(format)
        @format = format
      end

      # DSL Setter
      # Is the argument a list of options? If true it will be assumed that
      # this argument will be an array of objects of the sort set as type
      #
      # @param bool, Boolean value
      def list(bool)
        raise InvalidBooleanError unless [true,false].include? bool
        @list = bool
      end

      # DSL Setter
      # Is the argument a required?
      #
      # @param bool, Boolean value
      def required(bool)
        raise InvalidBooleanError unless [true,false].include? bool
        @required = bool
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
        @type = type
      end

      # TODO: this may not need to be included here
      def values(values=[])
        raise InvalidValuesError unless values.class == Array
        @values = values
      end
    end
  end
end

