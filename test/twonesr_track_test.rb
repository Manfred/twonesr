require File.expand_path('../test_helper', __FILE__)

require 'twonesr/track'

describe "Track" do
  it "should store relevant attributes" do
    creator = 'Seymore Bits'
    track = Twonesr::Track.new(:creator => creator)
    track.creator.should == creator
  end
end