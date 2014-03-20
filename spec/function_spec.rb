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
      arg.required true
      arg.type  :string
    end

    subject.argument :optional_argument do |arg|
      arg.type  :string
    end

    blank  = {}

    # no relevant args
    wrong1 = {
      :not_argument => "test value"
    }

    # just the optional arg
    wrong2 = {
      :optional_argument => "test value"
    }

    # just required, missing non-required
    valid1 = {
      :argument => "test value"
    }

    # required + optional
    valid2 = {
      :argument          => "test value",
      :optional_argument => "test value"
    }

    # ignores unexected key / values
    valid3 = {
      :argument => "test value",
      :not      => :relevant
    }


    subject.valid_args?(blank).should  == false
    subject.valid_args?(wrong1).should == false
    subject.valid_args?(wrong2).should == false
    subject.valid_args?(valid1).should == true
    subject.valid_args?(valid2).should == true
    subject.valid_args?(valid3).should == true
  end
end
