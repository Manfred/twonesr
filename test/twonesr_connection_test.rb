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
  
  it "should authenticate with correct credentials" do
    REST.expects(:post).with(
      'http://www.twones.com/login',
      '_method=POST&data%5BUser%5D%5Busername%5D=Jenny&data%5BUser%5D%5Bpassword%5D=fromtheblock12',
      {'Content-Type' => 'application/x-www-form-urlencoded'}
    ).returns(Response.for('successful-login'))
    
    @connection.authenticate
    @connection.cookie.should == Response.for('successful-login').headers['Set-Cookie']
  end
  
  it "should not authenticate with incorrect credentials" do
    REST.expects(:post).with(
      'http://www.twones.com/login',
      '_method=POST&data%5BUser%5D%5Busername%5D=Jenny&data%5BUser%5D%5Bpassword%5D=fromtheblock12',
      {'Content-Type' => 'application/x-www-form-urlencoded'}
    ).returns(Response.for('failed-login'))
    
    lambda {
      @connection.authenticate
    }.should.raise(Twonesr::Connection::ConnectionError)
    @connection.cookie.should.be.nil
  end
end

describe "A connected Connection" do
  before do
    REST.stubs(:post).with(
      'http://www.twones.com/login',
      '_method=POST&data%5BUser%5D%5Busername%5D=Jenny&data%5BUser%5D%5Bpassword%5D=fromtheblock12',
      {'Content-Type' => 'application/x-www-form-urlencoded'}
    ).returns(Response.for('successful-login'))
    @connection = Factory.connection.instantiate
    @connection.authenticate
  end
  
  it "should coerce to a hash" do
    @connection.to_hash.should == {
      'meta' => [
        { 'http://twones.com/ns/jspf#authName'  => @connection.username },
        { 'http://twones.com/ns/jspf#authToken' => Twonesr::Connection::API_TOKEN }
      ]
    }
  end
end