ENV['RAILS_ENV'] ||= 'development'
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = { 
    :session_key => '_green_label_session', 
    :secret      => 'dfb76bc1f2fed160d2e0f49f1a2a514e2c4160c163298ca46372000da37bc20bd59408ad0a5e536f567cd3bbd8524bcd3a54b08ae7f639c5307896148cdf1507' 
  }
    
  # only needed for import of addresses
  config.gem 'fastercsv', :lib => 'faster_csv'
  config.gem 'activemerchant', :lib => 'active_merchant'
  config.gem 'net-ssh', :lib => 'net/ssh'
  config.gem 'collectiveidea-awesome_nested_set',
           :lib => 'awesome_nested_set',  :source => 'http://gems.github.com'
  config.load_paths += %W(#{RAILS_ROOT}/app/lib)
           
end


# fix field with errors line breaking
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
"<span class='field_with_errors'>#{html_tag}</span>" }

ActionMailer::Base.delivery_method = :sendmail
# ActionMailer::Base.raise_delivery_errors = true

require 'optimized'

#ExceptionNotifier.exception_recipients = %w(gustin@entryway.net)
#ExceptionNotifier.email_prefix = "[GREEN_LABEL] "

