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
end
