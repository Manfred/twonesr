require 'uri'

module Twonesr
  class ConnectionError < StandardError
    attr_accessor :response
    
    def initialize(message, response=nil)
      super("#{message} (#{response.status_code})")
      @response = response
    end
  end
  
  class Connection
    attr_accessor :username
    attr_accessor :password
    attr_accessor :cookie
    attr_accessor :token
    attr_accessor :user_id
    
    def initialize(attributes={})
      unless attributes.empty?
        self.username, self.password = attributes[:username], attributes[:password]
      end
    end
    
    def authenticated?
      !cookie.nil?
    end
    
    def connected?
      !token.nil?
    end
    
    def authentication_cookie
      cookie.split(';').first
    end
    
    def authenticate
      headers = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
      params  = { '_method' => 'POST',
        'data[User][username]' => username,
        'data[User][password]' => password
      }
      response = REST.post(Twonesr::Routes.login_url, params.url_encode, headers)
      if response.found?
        @cookie = response.headers['set-cookie'].first
      else
        @cookie = nil
        raise Twonesr::ConnectionError.new("Authentication failed", response)
      end
      response
    end
    
    def retrieve_account_information
      response = get(Twonesr::Routes.welcome_url)
      if response.ok?
        match = /TwonesUtil\.addOn\.authenticate\([^,]*, "([a-z0-9]*)"\);/.match(response.body)
        @token = match[1]
        
        match = /\/img\/User\/\d*\/(\d*)\//.match(response.body)
        @user_id = match[1]
      else
        @token = nil
        @user_id = nil
        raise Twonesr::ConnectionError.new("Failed to retrieve account information", response)
      end
    end
    
    def post(url, data)
      headers = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
      response = REST.post(url, data.url_encode, headers)
      unless response.ok?
        raise Twonesr::ConnectionError.new("Failed to post to the Twones API", response)
      end
      response
    end
    
    def get(url)
      headers = { 'Cookie' => authentication_cookie }
      REST.get(url, headers)
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