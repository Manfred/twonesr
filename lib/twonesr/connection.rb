require 'uri'

module Twonesr
  class ConnectionError < StandardError
    attr_accessor :response
    
    def initialize(message, response=nil)
      super(message)
      @response = response
    end
  end
  
  class Connection
    API_TOKEN                = '36288e7ec80fe74f52580a6eb0b712529a9824e7'
    
    attr_accessor :username
    attr_accessor :password
    attr_accessor :cookie
    
    def initialize(attributes={})
      unless attributes.empty?
        self.username, self.password = attributes[:username], attributes[:password]
      end
    end
    
    def authenticate
      headers = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
      params  = { '_method' => 'POST',
        'data[User][username]' => username,
        'data[User][password]' => password
      }
      response = REST.post(Twonesr::Routes.login_url, params.url_encode, headers)
      if response.found?
        @cookie = response.headers['Set-Cookie']
      else
        @cookie = nil
        # FIXME: be more explicit about what went wrong
        raise Twonesr::ConnectionError.new("Connection failed, possibly because you username and password are not correct.", response)
      end
    end
    
    def post(url, data)
      headers = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
      response = REST.post(url, data.url_encode, headers)
      unless response.ok?
        raise Twonesr::ConnectionError.new("Failed to post to the Twones API (#{response.status_code}).", response)
      end
    end
    
    def to_hash
      {
        'meta' => [
          { 'http://twones.com/ns/jspf#authName'  => username },
          { 'http://twones.com/ns/jspf#authToken' => API_TOKEN }
        ]
      }
    end
  end
end