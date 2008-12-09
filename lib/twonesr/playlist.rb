module Twonesr
  class Playlist
    include DataMapper::Resource
    property :id,         Serial
    property :identifier, String
    
    has n, :tracks
    
    def to_hash
      {
        'track'      => tracks.map(&:to_hash),
        'identifier' => identifier
      }
    end
  end
end