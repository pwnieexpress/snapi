module Snapi
  module Capabilities
    Function = Struct.new(:arguments, :return_type ) do
      def argument(name)
        arg = Argument.new
        if block_given?
          yield(arg)
        end
        self.arguments = {} if self.arguments == nil
        self.arguments[name] = arg.attributes
      end

      def return(type)
        valid = %w{ none raw structured }.include? type.to_s
        raise InvalidReturnTypeError unless valid

        self.return_type = type
      end

      def to_hash
        { return_type: return_type }.merge (arguments||{})
      end

    end
  end
end
