require 'spec_helper'

describe Snapi::Argument do
  it "is a class"  do
    subject.class.class.should == Class
  end

  it "has an attributes hash" do
    subject.attributes.should == {}
  end

  it "responds to hash style queries" do
    subject[:does_not_exist].should == nil
  end

  it "responds to hash style queries" do
    subject[:default_value] = "some value"
    subject[:default_value].should == subject.attributes[:default_value]
  end

  it "protects from illegal keys being set" do
    begin
    subject[:dude_why_would_you_do_this] = "WHO CARES WHAT THIS IS BECAUSE IT WILL NOT GET SET"
    rescue => error
      error.class.should == Snapi::InvalidArgumentAttributeError
    end
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
    subject.attributes.keys.sort.should == []
  end

  describe "can validated types such as" do
    it ":boolean" do
      a = Snapi::Argument.new
      a.type :boolean
      a.valid_input?(true).should     == true
      a.valid_input?(false).should    == true
      a.valid_input?(String).should   == false
      a.valid_input?("String").should == false
      a.valid_input?({}).should       == false
      a.valid_input?([]).should       == false
    end

    it ":string" do
      a = Snapi::Argument.new
      a.type :string
      a.valid_input?(10.0).should     == false
      a.valid_input?(100).should      == false
      a.valid_input?(false).should    == false
      a.valid_input?([]).should       == false
      a.valid_input?({}).should       == false
      a.valid_input?(String).should   == false
      a.valid_input?("String").should == true
      a.valid_input?(true).should     == false
    end

    it ":string with format" do
      a = Snapi::Argument.new
      a.type :string
      a.format :ip
      a.valid_input?(10.0).should          == false
      a.valid_input?(100).should           == false
      a.valid_input?("192.168.1.1").should == true
      a.valid_input?(false).should         == false
      a.valid_input?([]).should            == false
      a.valid_input?({}).should            == false
      a.valid_input?("String").should      == false
      a.valid_input?(String).should        == false
      a.valid_input?(true).should          == false
    end

    it ":enum with values" do
      a = Snapi::Argument.new
      a.type :enum
      a.values [:a,:b,:c]
      a.valid_input?(10.0).should     == false
      a.valid_input?(100).should      == false
      a.valid_input?(:a).should       == true
      a.valid_input?(:b).should       == true
      a.valid_input?(:c).should       == true
      a.valid_input?(false).should    == false
      a.valid_input?([]).should       == false
      a.valid_input?({}).should       == false
      a.valid_input?("String").should == false
      a.valid_input?(String).should   == false
      a.valid_input?(true).should     == false
    end

    it ":number" do
      a = Snapi::Argument.new
      a.type :number
      a.valid_input?(100000000).should == true
      a.valid_input?(10.0).should      == false
      a.valid_input?(100).should       == true
      a.valid_input?(:a).should        == false
      a.valid_input?(:b).should        == false
      a.valid_input?(:c).should        == false
      a.valid_input?(false).should     == false
      a.valid_input?([]).should        == false
      a.valid_input?({}).should        == false
      a.valid_input?("String").should  == false
      a.valid_input?(String).should    == false
      a.valid_input?(true).should      == false
    end

    it ":timestamp" do
      pending
    end
  end
end

