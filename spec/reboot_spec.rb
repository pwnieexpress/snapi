require 'rspec'
require 'pry'

#class BinRunner < Snapi::Capability
#  function "run" do |fn|
#    fn.argument "command" do |arg|
#      arg.default_value nil
#      arg.required true
#      arg.list false
#      arg.type :string
#    end
#    fn.returned_type :raw
#  end
#end

module Snapi
  module Capabilities
    Capability = Struct.new(:functions) do
      def function(name, &blk)
        fn = Function.new
        yield(fn)
        self.functions = {} if self.functions == nil
        self.functions[name] = fn.to_hash
      end
    end

    Function = Struct.new(:arguments, :return_type ) do
      def argument(name, &blk)
        arg = Argument.new
        yield(arg)
        self.arguments = {} if self.arguments == nil
        self.arguments[name] = arg.attributes
      end

      def return(type)
        self.return_type = type
      end

      def to_hash
        { return_type: return_type }.merge arguments
      end
    end

    class Argument
      attr_accessor :default_value, :required, :list, :type
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

describe Snapi::Capabilities::Capability do
  it "can take a function" do
    subject.function :test_function do |fn|
      fn.argument :test_arg do |arg|
        arg.default_value = "test"
        arg.list = true
        arg.required = true
        arg.type = "string"
      end
      fn.return "string"
    end
    expected_return = {:test_function=> {:return_type=>"string", :test_arg=> {:default_value=>"test", :required=>true, :list=>true, :type=>"string"}}}
    subject.functions.should == expected_return
  end
end

describe Snapi::Capabilities::Function do
  it "can take an argument" do
    subject.argument :test do |arg|
      arg.default_value = "test"
      arg.list = true
      arg.required = true
      arg.type = "string"
    end

    subject.argument :test2 do |arg|
      arg.default_value = "testing more"
      arg.list = false
      arg.required = true
      arg.type = "string"
    end

    subject.arguments[:test].class.should == Hash
    subject.arguments[:test2][:list].should == false

  end
end

describe Snapi::Capabilities::Argument do
  it "is a class"  do
    subject.class.class.should == Class
  end

      #attr_accessor :default_value, :required, :list, :type
  it "can have default_value set" do
    subject.default_value = "test"
    subject.default_value.should == "test"
  end

  it "can have required set" do
    subject.required = true
    subject.required.should == true
  end

  it "can have list set" do
    subject.list = true
    subject.list.should == true
  end

  it "can have type set" do
    subject.type = :string
    subject.type.should == :string
  end

  it "can return a hash of its own options" do
    subject.attributes.keys.sort.should == [:default_value, :list, :required, :type]
  end
end
