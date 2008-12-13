require File.expand_path('../test_helper', __FILE__)

describe "Routes" do
  it "should return actual routes" do
    [:login_url, :add_playlist_url, :welcome_url].each do |route|
      Twonesr::Routes.send(route).should.not.be.blank
    end
  end
  
  it "should generate message urls for various collections" do
    Twonesr::Routes.messages_url(:collection => 'solo', :id => '1030').should == \
      'http://www.twones.com/users/messages/collection:solo/id:1030'
    Twonesr::Routes.messages_url(:collection => 'friends', :id => '1030').should == \
      'http://www.twones.com/users/messages/collection:friends/id:1030'
    Twonesr::Routes.messages_url(:collection => 'replies').should == \
      'http://www.twones.com/users/messages/collection:replies'
  end
end