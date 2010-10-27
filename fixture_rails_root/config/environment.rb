# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.9' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

class TestGemLocator < Rails::Plugin::Locator
  def plugins
    Rails::Plugin.new(File.join(File.dirname(__FILE__), *%w(.. ..)))
  end
end

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.plugin_locators << TestGemLocator

  config.gem 'friendly_id'
  config.gem 'acts_as_singleton'
  config.gem 'awesome_nested_set'
  config.gem 'aasm'
  config.gem 'will_paginate'
  config.gem 'rails_xss'
  config.gem 'ssl_requirement'
  config.gem 'carrierwave'
end
