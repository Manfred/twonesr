require 'uri'

module Twonesr
  class Connection
    class ConnectionError < StandardError; end
    
    API_TOKEN = '36288e7ec80fe74f52580a6eb0b712529a9824e7'
    DOMAIN    = 'www.townes.com'
    
    attr_accessor :username
    attr_accessor :password
    attr_accessor :cookie
    
    def initialize(attributes={})
      unless attributes.empty?
        self.username, self.password = attributes[:username], attributes[:password]
      end
    end
    
    def login_url
      URI::HTTP.build(:host => DOMAIN, :path => '/login').to_s
    end
    
    def authenticate
      headers = { 'Content-Type' => 'application/x-www-form-urlencoded' }
      params  = { '_method' => 'POST',
        'data[User][username]' => username,
        'data[User][password]' => password
      }
      response = REST.post(login_url, params.url_encode, headers)
      if response.status_code == 302
        @cookie = response.headers['Set-Cookie']
      else
        @cookie = nil
        # FIXME: be more explicit about what went wrong
        raise ConnectionError, "Connection failed, possibly because you username and password are not correct."
      end
    end
    
    def to_hash
      require_connection!
      {
        'meta' => [
          { 'http://twones.com/ns/jspf#authName'  => username },
          { 'http://twones.com/ns/jspf#authToken' => API_TOKEN }
        ]
      }
    end
    
    private
    
    def require_connection!
      unless cookie
        raise ConnectionError, "A connection is needed to do this, please start a connection first using Twonesr.establish_connection."
      end
    end
  end
end