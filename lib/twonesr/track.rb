module Twonesr
  class Track
    ATTRIBUTES = [:creator, :title, :year, :album, :duration, :trackNum]
    attr_accessor *ATTRIBUTES
    
    def initialize(attributes={})
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", attributes[attribute]) if attributes[attribute]
      end
    end
  end
end