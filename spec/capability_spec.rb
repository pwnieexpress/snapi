require "spec_helper"

describe Snapi::Capability do
  describe "has a namespace which" do
    it "can convert its class name into a route namespace" do
      subject.class.namespace.should == :capability
    end

    it "passes this to inherited Capability objects" do
      LadyRainicornAndPrinceMonochromocorn = Class.new(subject.class)
      LadyRainicornAndPrinceMonochromocorn.namespace.should == :lady_rainicorn_and_prince_monochromocorn
    end

    it "can return a hash representation of itself" do
      class PrinceLemonGrab < Snapi::Capability
        function :summon_zombies do |fn|
          fn.return :raw
        end
      end
      lemon_grab = {:prince_lemon_grab => {:summon_zombies => { :return_type => :raw}}}

      PrinceLemonGrab.to_hash.should == lemon_grab
    end
  end

  describe "DSL" do
    it "can take a function" do
      class PrincessBubblegm < Snapi::Capability
        function :create_candy_person do |fn|
          fn.argument :candy_base do |arg|
            arg.default_value "sugar"
            arg.format :anything
            arg.list true
            arg.required true
            arg.type :enum
          end
          fn.return :structured
        end
      end

      expected_return = {
        :create_candy_person => {
          :return_type =>:structured,
          :candy_base  => {
            :default_value => "sugar",
            :format => :anything,
            :required => true,
            :list => true,
            :type => :enum,
            :values => nil}
          }
        }
      PrincessBubblegm.functions.should == expected_return
    end

    it "doesn't shared functions between inherited classes" do
      class FinnTheHuman < Snapi::Capability
        function :enchyridion do |fn|
          fn.return :raw
        end
      end
      class JakeTheDog < Snapi::Capability
        function :beemo do |fn|
          fn.return :raw
        end
      end

      FinnTheHuman.functions[:enchyridion].should_not == nil
      FinnTheHuman.functions[:beemo].should           == nil

      JakeTheDog.functions[:enchyridion].should == nil
      JakeTheDog.functions[:beemo].should_not   == nil

      Snapi::Capability.functions.should == nil
      Snapi::Capability.functions.should == nil
    end
  end
end


