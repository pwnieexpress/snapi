module Snapi
  module Capabilities
   class Argument
      def default_value(val)
        @default_value = val
      end
      def required(bool)
        @required = bool
      end
      def list(bool)
        @list = bool
      end
      def type(type)
        @type = type
      end
      def attributes
        {
          :default_value => @default_value,
          :required => @required,
          :list => @list,
          :type => @type
        }
      end
    end
  end
end

