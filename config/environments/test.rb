# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Tell ActionMailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

config.gem 'rspec-rails', :lib => 'spec/rails'
config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
config.gem 'carlosbrando-remarkable',  :lib => 'remarkable', :source => 'http://gems.github.com'

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  ActiveMerchant::Billing::LinkpointGateway.pem_file = 
    File.read(RAILS_ROOT  + '/config/certs/1171936.pem' ) 
end

config.to_prepare do
  OrderTransaction.gateway =
    ActiveMerchant::Billing::LinkpointGateway.new(
        :login => '1171936'
    )
end