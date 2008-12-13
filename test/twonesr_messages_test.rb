require File.expand_path('../test_helper', __FILE__)

describe "A list of Messages" do
  before do
    connection = Factory.connection.instantiate
    connection.cookie = Response.attributes_for('successful-login')[1]['set-cookie'].first
    connection.token = '36288e7ec80fe74f52580a6eb0b712529a9824e7'
    connection.user_id = '3876'
    Twonesr.connection = connection
    
    @messages = Twonesr::Messages.new
  end
  
  it "should fetch a list of friends" do
    Twonesr.connection.expects(:get).with('http://www.twones.com/users/messages/collection:friends/id:3876').returns(
      Response.for('successfull-message-collection-friends')
    )
    messages = @messages.friends
    messages.length.should == 15
    messages[0, 3].should == [
      {:name=>"Pepijn", :body=>"Ballin;!", :posted_at=>"2 days, 5 hours ago"},
      {
        :name=>"Sandder",
        :body=>"Kunnen we elkaars smaak ineens niet meer flamen?",
        :posted_at=>"1 week, 2 days ago"
      },
      {
        :name=>"Sandder",
        :body=>"Wat is er gebeurd?",
        :posted_at=>"1 week, 2 days ago"
      }
    ]
  end
end