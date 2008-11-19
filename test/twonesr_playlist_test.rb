require File.expand_path('../test_helper', __FILE__)

describe "Playlist" do
  it "should store relevant attributes" do
    identifier = 'itunes'
    track = Twonesr::Playlist.new(:identifier => identifier)
    track.identifier.should == identifier
  end
end

describe "A Playlist" do
  before do
    @attributes = { :identifier => 'Seymour Bits' }
    @track = Twonesr::Track.new(@attributes)
  end
end