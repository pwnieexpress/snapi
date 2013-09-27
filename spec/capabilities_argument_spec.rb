require 'spec_helper'

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
    subject.attributes.keys.sort.should == [:default_value, :list, :required, :type, :values]
  end
end

