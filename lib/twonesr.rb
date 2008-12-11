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
      @playlist ||= Twonesr::Playlist.new
    end
    
    def establish_connection(attributes={})
      @connection ||= Twonesr::Connection.new(attributes)
    end
    
    def to_hash
      { 'playlist' => playlist.to_hash.merge(connection.to_hash) }
    end
    
    attr_accessor :service_name
    attr_accessor :connection
  end
  self.service_name = '%{ Twonesr }'
end

require 'twonesr/connection'
require 'twonesr/playlist'
require 'twonesr/track'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!