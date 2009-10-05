ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'spec'
require 'spec/rails'
require File.dirname(__FILE__) + '/pebbles_factory'

Dir.glob("#{File.dirname(__FILE__)}/../spec/factories/*.rb").each{|factory| require factory}


Spec::Runner.configure do |config|
  config.fixture_path = "#{File.dirname(__FILE__)}/../spec/fixtures"
end
