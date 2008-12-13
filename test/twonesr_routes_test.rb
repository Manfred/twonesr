require File.expand_path('../test_helper', __FILE__)

describe "Routes" do
  it "should return actual routes" do
    [:login_url, :add_playlist_url, :welcome_url].each do |route|
      Twonesr::Routes.send(route).should.not.be.blank
    end
  end
end