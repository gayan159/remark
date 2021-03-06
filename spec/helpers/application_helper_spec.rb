require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe "tracking code" do
  before(:each) do
    @setting = FactoryGirl.create(:tracking)
  end
  
  describe "in production environment" do
    before(:each) do
      Rails.env = 'production'
    end
    
    after(:each) do
      Rails.env = 'test'
    end
    
    it "should be retrieved from the settings" do
      helper.stub(:setting => "some_tracking_code")
      helper.tracking.should == @setting.value
    end
  end

  it "checks the environment isn't still production" do
    Rails.env.should_not == 'production'
  end
end

describe "application name" do
  before(:each) do
    @setting = FactoryGirl.create(:application_name)
  end
  
  it "should be retrieved from the settings" do
    helper.stub(:setting => "Application Name")
    helper.setting(:name).should == @setting.value
  end
end
