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
    @track = Factory.track.instantiate
  end
  
  it "should coerce to hash" do
    @track.to_hash.should == {
      'creator' => @track.creator,
      'title'   => @track.title,
      'meta'    => [{ 'http://twones.com/ns/jspf#metaService' => 'itunes' }]
    }
  end
end