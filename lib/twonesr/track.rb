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
  end
end 