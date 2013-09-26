require 'rspec'
require 'pry'

module Snapi
  class Capability
    class << self
      attr_accessor :functions
    end
    def self.function(name)
      fn = Capabilities::Function.new
      if block_given?
        yield(fn)
      end
      @functions ||= {}
      @functions[name] = fn.to_hash
    end
  end

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
        self.return_type = type
      end

      def to_hash
        { return_type: return_type }.merge arguments
      end
    end

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

# class BinRunner < Snapi::Capability
#   function :run do |fn|
#     fn.argument :command do |arg|
#       arg.default_value nil
#       arg.required true
#       arg.list false
#       arg.type :string
#     end
#     fn.return :raw
#   end
#
#   function :hostname do |fn|
#     fn.argument :hostname do |arg|
#       arg.type :string
#     end
#     fn.return :raw
#   end
# end



describe Snapi::Capability do
  it "can take a function" do
    subject.class.function :test_function do |fn|
      fn.argument :test_arg do |arg|
        arg.default_value "test"
        arg.list true
        arg.required true
        arg.type "string"
      end
      fn.return "string"
    end
    expected_return = {:test_function=> {:return_type=>"string", :test_arg=> {:default_value=>"test", :required=>true, :list=>true, :type=>"string"}}}
    subject.class.functions.should == expected_return
  end
end

describe Snapi::Capabilities::Function do
  it "can take an argument" do
    subject.argument :test do |arg|
      arg.default_value  "test"
      arg.list  true
      arg.required  true
      arg.type  "string"
    end

    subject.argument :test2 do |arg|
      arg.default_value  "testing more"
      arg.list  false
      arg.required  true
      arg.type  "string"
    end

    subject.arguments[:test].class.should == Hash
    subject.arguments[:test2][:list].should == false

  end
end

describe Snapi::Capabilities::Argument do
  it "is a class"  do
    subject.class.class.should == Class
  end

  it "can have default_value set" do
    subject.default_value("test").should == "test"
  end

  it "can have required set" do
    subject.required(true).should == true
  end

  it "can have list set" do
    subject.list(true).should == true
  end

  it "can have type set" do
    subject.type(:string).should == :string
  end

  it "can return a hash of its own options" do
    subject.attributes.keys.sort.should == [:default_value, :list, :required, :type]
  end
end
