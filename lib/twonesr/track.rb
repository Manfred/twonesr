module Twonesr
  class Track
    include DataMapper::Resource
    property :id,       Serial
    property :creator,  String
    property :title,    String
    property :year,     Integer
    property :album,    String
    property :duration, Integer
    property :trackNum, Integer
    
    belongs_to :playlist
    
    def to_hash
      {
        'creator' => creator,
        'title'   => title
      }
    end
  end
end