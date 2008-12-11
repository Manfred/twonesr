require 'rubygems' rescue LoadError
require 'test/spec'
require 'mocha'

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'twonesr'

$:.unshift(File.expand_path('../test_lib', __FILE__))
require 'factory'
require 'response'

require 'net/http'
module Net
  class HTTP
    def start
      raise Exception, "Please don't make actual HTTP connection in tests."
    end
  end
end