require "spec_helper"

describe Snapi::Capability do
  describe "has a namespace which" do
    it "can convert its class name into a route namespace" do
      subject.class.namespace.should == :capability
    end

    it "passes this to inherited Capability objects" do
      SuperMegaCrazyName1Space = Class.new(subject.class)

      SuperMegaCrazyName1Space.namespace.should == :super_mega_crazy_name1_space
    end

    it "can return a hash representation of itself" do
      class CapabilityFromBeyondTheGrave < Snapi::Capability
        function :summon_zombies do |fn|
          fn.return :monsters
        end
      end
      cfbtg_hash = {:capability_from_beyond_the_grave => {:summon_zombies => { :return_type => :monsters}}}

      CapabilityFromBeyondTheGrave.to_hash.should == cfbtg_hash
    end
  end

  describe "DSL" do
    it "can take a function" do
      subject.class.function :test_function do |fn|
        fn.argument :test_arg do |arg|
          arg.default_value "test"
          arg.list true
          arg.required true
          arg.type :string
        end
        fn.return :raw
      end
      expected_return = {:test_function=> {:return_type=>:raw, :test_arg=> {:default_value=>"test", :required=>true, :list=>true, :type=>:string}}}
      subject.class.functions.should == expected_return
    end

    it "doesn't shared functions between inherited classes" do
      class Klass1 < Snapi::Capability
        function :test do |fn|
          fn.return :raw
        end
      end
      class Klass2 < Snapi::Capability
        function :not_test do |fn|
          fn.return :raw
        end
      end

      Klass1.functions[:test].should_not == nil
      Klass2.functions[:test].should == nil
      Klass1.functions[:not_test].should == nil
      Klass2.functions[:not_test].should_not == nil

      Snapi::Capability.functions[:test].should == nil
      Snapi::Capability.functions[:not_test].should == nil
    end
  end
end


