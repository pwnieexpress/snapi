module Snapi
  module Capabilities
   class Argument

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

      def default_value(val="")
        raise InvalidStringError unless val.class == String
        @default_value = val
      end

      def format(format)
        raise InvalidFormatError unless Validator.valid_regex_format?(format)
        @format = format
      end

      def list(bool)
        raise InvalidBooleanError unless [true,false].include? bool
        @list = bool
      end

      def required(bool)
        raise InvalidBooleanError unless [true,false].include? bool
        @required = bool
      end

      def type(type)
        valid_types = [:boolean, :enum, :string, :number, :timestamp]
        valid = valid_types.include?(type)

        raise InvalidTypeError unless valid

        @type = type
      end

      def values(values=[])
        raise InvalidValuesError unless values.class == Array
        @values = values
      end

    end
  end
end

