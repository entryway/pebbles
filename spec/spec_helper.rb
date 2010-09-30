ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../fixture_rails_root/config/environment")

require 'rubygems'
require 'pebbles'
require 'factory_girl'
require 'spec'
require 'spec/autorun'
require 'spec/rails'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'factories', '*rb'))].each {|f| require f}

Spec::Runner.configure do |config|
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures = false
end
