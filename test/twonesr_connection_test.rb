require File.expand_path('../test_helper', __FILE__)

describe "Connection" do
  before do
    @credentials = { :username => 'Jenny', :token => 'fromtheblock12' }
    Twonesr::Connection.credentials = @credentials
  end
  
  it "should hold credentials" do
    Twonesr::Connection.credentials.should == @credentials
  end
  
  it "should coerce to a hash" do
    Twonesr::Connection.to_hash.should == {
      'meta' => [
        { 'http://twones.com/ns/jspf#authName'  => @credentials[:username] },
        { 'http://twones.com/ns/jspf#authToken' => @credentials[:token] }
      ]
    }
  end
end