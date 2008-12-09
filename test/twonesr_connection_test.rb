require File.expand_path('../test_helper', __FILE__)

describe "Connection" do
  it "should store relevant attributes" do
    username = 'Jenny'; password = 'fromtheblock23'
    connection = Twonesr::Connection.new(:username => username, :password => password)
    connection.username.should == username
    connection.password.should == password
  end
end

describe "A Connection" do
  before do
    @connection = Factory.connection.instantiate
  end
  
  it "should coerce to a hash" do
    @connection.token = 'ad34dg56'
    @connection.to_hash.should == {
      'meta' => [
        { 'http://twones.com/ns/jspf#authName'  => @connection.username },
        { 'http://twones.com/ns/jspf#authToken' => @connection.token }
      ]
    }
  end
end