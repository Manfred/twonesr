# {"playlist"=>
#   {"track"=>
#     [{"creator"=>"Quasimoto",
#       "title"=>"The Clown (Episode C)",
#       "meta"=>[{"http://twones.com/ns/jspf#metaService"=>"itunes"}],
#       "year"=>2005,
#       "album"=>"The Further Adventures Of Lord Quas",
#       "duration"=>179040,
#       "trackNum"=>23}],
#    "meta"=>
#     [{"http://twones.com/ns/jspf#authName"=>"Manfred"},
#      {"http://twones.com/ns/jspf#authToken"=>
#        "36288e7ec80fe74f52580a6eb0b712529a9824e7"}],
#    "identifier"=>"itunes"}}
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