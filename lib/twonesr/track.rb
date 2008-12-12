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
      hash = {}
      %w(creator title year album duration trackNum).each do |key|
        value = send(key)
        hash[key] = value unless value.blank?
      end
      hash['meta'] = [{ 'http://twones.com/ns/jspf#metaService' => 'itunes' }]
      hash
    end
  end
end