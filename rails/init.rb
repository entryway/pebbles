require 'pebbles'

class ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
  include SslRequirement
  include Pebbles::Shipping
  include Pebbles::Cart
  include Pebbles::Categories

  filter_parameter_logging :credit_card
  helper_method :active_shipping_region_id
  helper_method :active_shipping_method_id
  helper_method :current_cart
  helper_method :categories
end

config.gem 'collectiveidea-awesome_nested_set',
           :lib => 'awesome_nested_set',  :source => 'http://gems.github.com'
config.gem "carrierwave"


ActiveSupport::Dependencies.load_paths << File.join(File.dirname(__FILE__), "..", 'app', 'lib')
ActiveSupport::Dependencies.load_paths << File.join(File.dirname(__FILE__), "..", 'app', 'notifiers')
ActiveSupport::Dependencies.load_paths << File.join(File.dirname(__FILE__), "..", "app", "uploaders")
%w(controllers helpers lib models notifiers views ).each  do |path|
  ActiveSupport::Dependencies.load_once_paths.delete File.join(File.dirname(__FILE__), "..", 'app', path) 
end
ActiveSupport::Dependencies.load_once_paths.delete File.join(File.dirname(__FILE__), "..", 'lib')



config.to_prepare do
  helpers = Dir.glob(File.join(File.dirname(__FILE__), '..','app','helpers','pebbles', '**', '*.rb'))
  helpers.each do |helper_file|
    class_name = eval(helper_file.gsub!(/^.+helpers\//, "")[0..-4].camelize)
    ApplicationController.helper(class_name)
  end
end

