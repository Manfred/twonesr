require File.expand_path('../test_helper', __FILE__)

describe "Twonesr" do
  it "should know it's own default service name" do
    Twonesr.service_name.should == '%{ Twonesr }'
  end
  
  it "should be possible to change the service name" do
    Twonesr.service_name = 'Changed'
    Twonesr.service_name.should == 'Changed'
  end
end