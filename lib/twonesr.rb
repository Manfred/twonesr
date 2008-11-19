require 'rubygems' rescue LoadError
require 'rest'
require 'json'
require 'dm-core'

$:.unshift(File.expand_path('../lib', __FILE__))

module Twonesr
  class << self
    attr_accessor :service_name
  end
  self.service_name = '%{ Twonesr }'
end

require 'twonesr/playlist'
require 'twonesr/track'