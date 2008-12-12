require 'rubygems' rescue LoadError
require 'active_support'
require 'dm-core'
require 'rest'
require 'json'

$:.unshift(File.expand_path('../lib', __FILE__))
require 'core_ext'

module Twonesr
  class << self
    def playlist
      @playlist ||= Twonesr::Playlist.new(:identifier => 'itunes')
    end
    
    def establish_connection(attributes={})
      @connection = Twonesr::Connection.new(attributes)
    end
    
    def post
      connection.post(Twonesr::Routes.add_playlist_url, {'playlist' => to_json})
    end
    
    def to_hash
      { 'playlist' => playlist.to_hash.merge(connection.to_hash) }
    end
    
    def to_json
      to_hash.to_json
    end
    
    attr_accessor :service_name
    attr_accessor :connection
  end
  self.service_name = '%{ Twonesr }'
end

require 'twonesr/routes'
require 'twonesr/connection'
require 'twonesr/playlist'
require 'twonesr/track'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!