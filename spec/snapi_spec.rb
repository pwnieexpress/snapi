require 'spec_helper'

describe Snapi do
  it "is a module" do
    Snapi.class.should == Module
  end

  it "can return a hash of registered capabilities" do
    Snapi.capabilities.class.should == Hash
    Snapi.capabilities[:basic_capability].should == Snapi::BasicCapability
  end

  it "provides direct hash style access to its capabilities" do
    Snapi[:basic_capability].should == Snapi.capabilities[:basic_capability]
  end

  it "allows other ruby classes to register as capabilities" do
    TmpClass = Class.new(Snapi::BasicCapability)

    Snapi.capabilities.length.should == 1
    Snapi.register_capability(TmpClass)

    Snapi.capabilities.length.should == 2
    Snapi[:tmp_class].should == TmpClass
  end

  it "provides a list of known capabilities" do
    Snapi.valid_capabilities.class.should == Array
    Snapi.valid_capabilities.should == [:basic_capability, :tmp_class]
  end

  it "provides a hash containing a full functionality disclosure" do
    hash = Snapi.capability_hash
    hash.class.should == Hash
    hash[:tmp_class].should == TmpClass.to_hash
    hash[:basic_capability].should == Snapi::BasicCapability.to_hash
  end

  it "can test is a capability is valid" do
    Snapi.has_capability?(:basic_capability).should == true
    Snapi.has_capability?(:sexy_ninja).should       == false # :(
  end
end
