require File.expand_path('../test_helper', __FILE__)

describe "Track" do
  it "should store relevant attributes" do
    creator = 'Seymour Bits'
    track = Twonesr::Track.new(:creator => creator)
    track.creator.should == creator
  end
end

describe "A Track" do
  before do
    @attributes = { :creator => 'Seymour Bits', :title => 'You Must Be The Bass' }
    @track = Twonesr::Track.new(@attributes)
  end
end