require 'spec_helper'

describe Snapi::Function do
  it "can take an argument" do
    subject.argument :test do |arg|
      arg.default_value  "test"
      arg.list  true
      arg.type  :string
    end

    subject.argument :test2 do |arg|
      arg.default_value  "testing more"
      arg.required  true
      arg.type  :string
    end

    subject.arguments[:test][:required].should == nil
    subject.arguments[:test2][:required].should == true

  end

  it "can validate a ruby hash of keys and values against its arguments" do
    subject.argument :argument do |arg|
      arg.default_value  "test"
      arg.required true
      arg.type  :string
    end

    subject.valid_args?({}).should == false
    subject.valid_args?({:not_argument => "test value"}).should == false
    subject.valid_args?({:argument => "test value"}).should == true
    # ignores
    subject.valid_args?({:argument => "test value", :not => :relevant}).should == true
  end
end
