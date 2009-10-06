require 'pebbles'

class ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
  include SslRequirement
  include Pebbles::Shipping
  include Pebbles::Cart
  include Pebbles::Categories

  filter_parameter_logging :credit_card

  helper_method :current_cart
  helper_method :categories
end

class ActionController::Routing::RouteSet
  def load_routes_with_clearance!
    clearance_routes = File.join(File.dirname(__FILE__), 
                       *%w[.. config pebbles_routes.rb])
    unless configuration_files.include? clearance_routes
      add_configuration_file(clearance_routes)
    end
    load_routes_without_clearance!
  end

  alias_method_chain :load_routes!, :clearance
end

config.gem 'activemerchant', :lib => 'active_merchant'

config.gem 'collectiveidea-awesome_nested_set',
           :lib => 'awesome_nested_set',  :source => 'http://gems.github.com'
config.gem "carrierwave"
config.gem "stephencelis-acts_as_singleton",
    :lib => "acts_as_singleton",
    :source => "http://gems.github.com"
config.gem "ssl_requirement"

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

