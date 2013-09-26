require "spec_helper"

describe Snapi::Capability do

  describe "has a namespace which" do
    it "can convert its class name into a route namespace" do
      subject.namespace.should == "capability"
    end

    it "passes this to inherited Capability objects" do
      SuperMegaCrazyName1Space = Class.new(subject.class)

      SuperMegaCrazyName1Space.new.namespace.should == "super_mega_crazy_name1_space"
    end
  end

  describe "has a configurable list of routes which" do
    it "comprises have routes with a meta information hash added as a setting via a class method" do
      class CapabilityFromBeyondTheGrave < Snapi::Capability
        route "summon_zombies", { "gravedigging" => true }
        route "sacrifice_population"
      end
      CapabilityFromBeyondTheGrave.routes.should == {"summon_zombies" => {"gravedigging" => true }, "sacrifice_population" => {}}
    end
  end

end
