require "spec_helper"
describe "Snapi::Validator" do
  it "is a module" do
    Snapi::Validator.class.should == Module
  end

  it "includes an array of format types it can validate" do
    Snapi::Validator.format_types.class.should == Array
  end

  it "can identify valid format types" do
    test_format = Snapi::Validator.format_types.shuffle.first
    Snapi::Validator.valid_regex_format?(test_format).should == true
  end

  it "can identify invalid format types" do
    test_format = :no_frakin_way_this_key_exists_seriously_dude
    Snapi::Validator.valid_regex_format?(test_format).should == false
  end

  it "offers an array of regular expressions in exchange for a format type" do
    ip_reg = Snapi::Validator.validation_regex[:ip]
    ip_reg.class.should                  == Array
    ip_reg.first.class.should            == Regexp
    ip_reg.first.respond_to?(:=~).should == true

    json_reg = Snapi::Validator.validation_regex[:json]
    json_reg.class.should                  == Array
    json_reg.first.class.should            == Class
    json_reg.first.respond_to?(:=~).should == true
  end

  it "will attempt to confirm if a string matches the specified regex" do
    Snapi::Validator.valid_input?( :ip, "192.168.10.129" ).should == true
    Snapi::Validator.valid_input?( :ip, "192.168.10.256" ).should == false
    Snapi::Validator.valid_input?( :ip, "Jake the Dog"   ).should == false
  end

  it "validates well-formed json" do
    Snapi::Validator.valid_input?( :json, "{}" ).should            == true
    Snapi::Validator.valid_input?( :json, "{'}" ).should           == false
    Snapi::Validator.valid_input?( :json, "{\"asdf\": 3}" ).should == true
    Snapi::Validator.valid_input?( :json, "{asdf: 3" ).should      == false
    Snapi::Validator.valid_input?( :json, "[{},{}]" ).should       == true
  end
end
