module Twonesr
  module Routes
    WWW_DOMAIN = 'www.twones.com'
    API_DOMAIN = 'api.twones.com'
    
    class << self
      def login_url
        URI::HTTP.build(:host => Twonesr::Routes::WWW_DOMAIN, :path => '/login').to_s
      end
      
      def add_playlist_url
        URI::HTTP.build(:host => Twonesr::Routes::API_DOMAIN, :path => '/v1/add').to_s
      end
      
      def welcome_url
        URI::HTTP.build(:host => Twonesr::Routes::WWW_DOMAIN, :path => '/users/firefox_installed', :query => 'cmd=login&v=0.5.5.395').to_s
      end
      
      def messages_url(params={})
        collection_path = ([:collection, :id].inject([]) do |path, param|
          path << "#{param}:#{params[param]}" unless params[param].blank?
          path
        end.join('/'))
        URI::HTTP.build(:host => Twonesr::Routes::WWW_DOMAIN, :path => "/users/messages/#{collection_path}").to_s
      end
    end
  end
end