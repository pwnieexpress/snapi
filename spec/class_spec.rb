require 'spec_helper'

describe "Class" do
  it "can return its own subclasses" do
    Aa = Class.new
    Bb = Class.new Aa
    Aa.subclasses.should == [Bb]
  end
end
