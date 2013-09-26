require 'spec_helper'

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
