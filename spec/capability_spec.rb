require "spec_helper"

describe Snapi::Capability do

  describe "has a namespace which" do
    it "can convert its class name into a route namespace" do
      subject.class.namespace.should == "capability"
    end

    it "passes this to inherited Capability objects" do
      SuperMegaCrazyName1Space = Class.new(subject.class)

      SuperMegaCrazyName1Space.namespace.should == "super_mega_crazy_name1_space"
    end
  end

  describe "can return a hash representation of itself" do
    it do
      class CapabilityFromBeyondTheGrave < Snapi::Capability
        route "summon_zombies"
      end
      cfbtg_hash = {"capability_from_beyond_the_grave" => {"summon_zombies" => {}}}

      CapabilityFromBeyondTheGrave.to_hash.should == cfbtg_hash
      Snapi::Capability.full_hash.should == {}.merge(cfbtg_hash)
    end
  end

  describe "has a configurable list of routes which" do
    it "comprises have routes with a meta information hash added as a setting via a class method" do
      class CapabilityFromBeyondTheGrave < Snapi::Capability
        route "summon_zombies", {}
      end
      CapabilityFromBeyondTheGrave.routes.should == {"summon_zombies" => {}}
    end

    it "takes an optional block" do
      class CapabilityFromBeyondTheGrave < Snapi::Capability
        route "summon_zombies" do |path|

          parameter path, "gravedigging", {
            "default_value" => false,
            "required" => false,
            "list" => false,
            "type" => "boolean"
          }

          returned_type path, "none"

        end

        route "test"
      end

      expected_hash = {
        "summon_zombies" => {
          "gravedigging" => {
            "default_value" => false,
            "required" => false,
            "list" => false,
            "type" => "boolean"
          },
          "returned_type" => "none"
        },
        "test" => {}
      }

      CapabilityFromBeyondTheGrave.routes.should == expected_hash

    end
  end

end
