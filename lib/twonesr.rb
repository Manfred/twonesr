require 'rubygems' rescue LoadError
require 'active_support'
require 'dm-core'
require 'rest'
require 'json'

$:.unshift(File.expand_path('../lib', __FILE__))

module Twonesr
  class << self
    def connection
      Twonesr::Connection
    end
    
    def playlist
      @playlist ||= Twonesr::Playlist.new
    end
    
    attr_accessor :service_name
  end
  self.service_name = '%{ Twonesr }'
end

require 'twonesr/connection'
require 'twonesr/playlist'
require 'twonesr/track'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!