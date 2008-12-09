require File.expand_path('../test_helper', __FILE__)

describe "Playlist" do
  it "should store relevant attributes" do
    identifier = 'iTunes'
    track = Twonesr::Playlist.new(:identifier => identifier)
    track.identifier.should == identifier
  end
end

describe "A Playlist" do
  before do
    @playlist = Factory.playlist.instantiate
  end
  
  it "should hold tracks" do
    track = Factory.track.instantiate
    @playlist.tracks << track
    @playlist.tracks.length.should == 1
    @playlist.tracks.first.should == track
  end
end

describe "A Playlist, with tracks" do
  before do
    @playlist = Factory.playlist.instantiate
    @playlist.tracks << Factory.track.instantiate
  end
  
  it "should coerce to hash" do
    @playlist.to_hash.should == {
      'track'      => @playlist.tracks.map(&:to_hash),
      'identifier' => @playlist.identifier
    }
  end
end