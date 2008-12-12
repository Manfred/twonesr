class Factory
  class << self
    def attributes
      {
        :connection => { :username => 'Jenny', :password => 'fromtheblock12' },
        :track => { :creator => 'Seymour Bits', :title => 'You Must Be The Bass' },
        :playlist => { :identifier => 'itunes' }
      }
    end
    
    def method_missing(m, *a, &b)
      if attributes.has_key?(m.to_sym)
        Factory.new(:subject => m.to_sym)
      else
        super
      end
    end
  end
  
  attr_accessor :subject
  
  def initialize(options={})
    raise ArgumentError, "Factory needs a subject" unless options.has_key?(:subject)
    @subject = options[:subject]
  end
  
  def attributes
    self.class.attributes[@subject]
  end
  
  def instantiate
    klass = "Twonesr::#{@subject.to_s.classify}".constantize
    klass.new(attributes)
  end
end

if __FILE__ == $0
  require 'test/unit'
  
  require 'rubygems'
  require 'active_support'
  
  module Twonesr
    class Track
      attr_accessor :attributes
      
      def initialize(attributes={})
        @attributes = attributes
      end
    end
  end
  
  class FactoryTest < Test::Unit::TestCase
    def test_should_instantiate_a_track
      track = Factory.track.instantiate
      assert track.kind_of?(Twonesr::Track)
    end
  end
end