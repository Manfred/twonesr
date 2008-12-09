module Twonesr
  class Connection
    class << self
      def to_hash
        {
          'meta' => [
            { 'http://twones.com/ns/jspf#authName'  => credentials[:username] },
            { 'http://twones.com/ns/jspf#authToken' => credentials[:token] }
          ]
        }
      end
      
      attr_accessor :credentials
    end
    self.credentials = {}
  end
end