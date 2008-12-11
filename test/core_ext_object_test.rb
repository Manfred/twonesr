require File.expand_path('../test_helper', __FILE__)

describe "An Object" do
  it "should url-encode its value" do
    object = Object.new
    object.expects(:to_s).returns('value')
    CGI.expects(:escape).with('value').returns('escaped-value')
    
    object.url_encode.should == 'escaped-value'
  end
  
  it "should url-encode a string because it's a kiddie of object" do
    'data[key]'.url_encode.should == 'data%5Bkey%5D'
  end
end