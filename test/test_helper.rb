require 'rubygems' rescue LoadError
require 'test/spec'

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'twonesr'

$:.unshift(File.expand_path('../test_lib', __FILE__))
require 'factory'