module Twonesr
  class Connection
    attr_accessor :username
    attr_accessor :password
    attr_accessor :token
    
    def initialize(attributes={})
      unless attributes.empty?
        self.username, self.password = attributes[:username], attributes[:password]
      end
    end
    
    def to_hash
      {
        'meta' => [
          { 'http://twones.com/ns/jspf#authName'  => username },
          { 'http://twones.com/ns/jspf#authToken' => token }
        ]
      }
    end
  end
end