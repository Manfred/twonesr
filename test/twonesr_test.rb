require File.expand_path('../test_helper', __FILE__)

describe "Twonesr" do
  it "should know it's own default service name" do
    Twonesr.service_name.should == '%{ Twonesr }'
  end
  
  it "should be possible to change the service name" do
    Twonesr.service_name = 'Changed'
    Twonesr.service_name.should == 'Changed'
  end
  
  it "should have a global playlist" do
    Twonesr.playlist.should == Twonesr.playlist
    Twonesr.playlist.should.be.kind_of(Twonesr::Playlist)
  end
  
  it "should have global messages" do
    Twonesr.messages.should == Twonesr.messages
    Twonesr.messages.should.be.kind_of(Twonesr::Messages)
  end
  
  it "should establish a connection" do
    credentials = {:username => 'Jenny', :password => 'fromtheblock12'}
    connection = Twonesr::Connection.new(credentials)
    connection.expects(:authenticate)
    connection.expects(:retrieve_account_information)
    Twonesr::Connection.expects(:new).with(credentials).returns(connection)
    
    Twonesr.establish_connection(credentials)
  end
end

describe "Twonesr, when connected" do
  before do
    connection = Factory.connection.instantiate
    connection.cookie = Response.attributes_for('successful-login')[1]['set-cookie'].first
    connection.token = '36288e7ec80fe74f52580a6eb0b712529a9824e7'
    
    Twonesr.connection = connection
  end
  
  it "should coerce all the global information to a hash" do
    hash = Twonesr.to_hash
    hash.should.has_key('playlist')
  end
  
  it "should post the current playlist" do
    Twonesr.connection.expects(:post).with(Twonesr::Routes.add_playlist_url, {'playlist' => Twonesr.to_json})
    Twonesr.post
  end
end