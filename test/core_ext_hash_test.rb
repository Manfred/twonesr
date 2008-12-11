require File.expand_path('../test_helper', __FILE__)

describe "A Hash" do
  it "should url-encode simple hashes" do
    {}.url_encode.should == ''
    {'key' => 'value'}.url_encode.should == 'key=value'
    {'key?' => 'value?'}.url_encode.should == 'key%3F=value%3F'
  end
  
  it "should url-encode hashes with multiple keys" do
    {'key1' => 'value1', 'key2' => 'value2'}.url_encode.should == 'key1=value1&key2=value2'
  end
end