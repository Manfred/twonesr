module Twonesr
  module Routes
    AUTHENTICATION_DOMAIN    = 'www.twones.com'
    API_DOMAIN               = 'api.twones.com'
    
    class << self
      def login_url
        URI::HTTP.build(:host => Twonesr::Routes::AUTHENTICATION_DOMAIN, :path => '/login').to_s
      end
      
      def add_playlist_url
        URI::HTTP.build(:host => Twonesr::Routes::API_DOMAIN, :path => '/v1/add').to_s
      end
    end
  end
end