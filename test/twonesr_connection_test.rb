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
  
  it "should not be autenticated" do
    @connection.should.not.be.authenticated
  end
  
  it "should not be connected" do
    @connection.should.not.be.connected
  end
  
  it "should authenticate with correct credentials" do
    REST.expects(:post).with(
      'http://www.twones.com/login',
      '_method=POST&data%5BUser%5D%5Busername%5D=Jenny&data%5BUser%5D%5Bpassword%5D=fromtheblock12',
      {'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'}
    ).returns(Response.for('successful-login'))
    
    @connection.authenticate
    @connection.should.be.authenticated
    @connection.cookie.should == Response.for('successful-login').headers['set-cookie'].first
  end
  
  it "should not authenticate with incorrect credentials" do
    REST.expects(:post).with(
      'http://www.twones.com/login',
      '_method=POST&data%5BUser%5D%5Busername%5D=Jenny&data%5BUser%5D%5Bpassword%5D=fromtheblock12',
      {'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'}
    ).returns(Response.for('failed-login'))
    
    lambda {
      @connection.authenticate
    }.should.raise(Twonesr::ConnectionError)
    @connection.should.not.be.authenticated
    @connection.cookie.should.be.nil
  end
end

describe "An authenticated Connection" do
  before do
    @connection = Factory.connection.instantiate
    @connection.cookie = Response.attributes_for('successful-login')[1]['set-cookie']
  end
  
  it "should be autenticated" do
    @connection.should.be.authenticated
  end
  
  it "should not be connected" do
    @connection.should.not.be.connected
  end
  
  it "should retrieve a token from the welcome page" do
    REST.expects(:get).with(
      'http://www.twones.com/users/firefox_installed?cmd=login&v=0.5.5.395',
      {'Cookie' => @connection.authentication_cookie }
    ).returns(Response.for('successful-token-retrieval'))
    
    @connection.retrieve_token
    @connection.should.be.connected
    @connection.token.should == '36288e7ec80fe74f52580a6eb0b712529a9824e7'
  end
  
  it "should not retrieve a token from the welcome page in the case of authentication failure" do
    REST.expects(:get).with(
      'http://www.twones.com/users/firefox_installed?cmd=login&v=0.5.5.395',
      {'Cookie' => @connection.authentication_cookie }
    ).returns(Response.for('failed-token-retrieval'))
    
    lambda {
      @connection.retrieve_token
    }.should.raise(Twonesr::ConnectionError)
    @connection.should.not.be.connected
    @connection.token.should.be.nil
  end
end

describe "A connected Connection" do
  before do
    @connection = Factory.connection.instantiate
    @connection.cookie = Response.attributes_for('successful-login')[1]['set-cookie']
    @connection.token = '36288e7ec80fe74f52580a6eb0b712529a9824e7'
  end
  
  it "should be autenticated" do
    @connection.should.be.authenticated
  end
  
  it "should be connected" do
    @connection.should.be.connected
  end
  
  it "should coerce to a hash" do
    @connection.to_hash.should == {
      'meta' => [
        { 'http://twones.com/ns/jspf#authName'  => @connection.username },
        { 'http://twones.com/ns/jspf#authToken' => @connection.token }
      ]
    }
  end
end