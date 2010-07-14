require 'pebbles'

class ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
#  include SslRequirement
  include Pebbles::Shipping
  include Pebbles::Cart
  include Pebbles::Categories

  filter_parameter_logging :credit_card

  helper_method :current_cart
end

class ActionController::Routing::RouteSet
  def load_routes_with_pebbles!
    pebbles_routes = File.join(File.dirname(__FILE__), 
                               *%w[.. config pebbles_routes.rb])
    unless configuration_files.include? pebbles_routes
      add_configuration_file(pebbles_routes)
    end
    load_routes_without_pebbles!
  end

  alias_method_chain :load_routes!, :pebbles
end


config.gem 'erubis'

config.gem 'activemerchant', :lib => 'active_merchant', :version => '1.4.2'
config.gem 'awesome_nested_set', :version => '1.4.3'
config.gem 'geokit', :version  => '1.5.0'
config.gem 'friendly_id', :version => '2.3.3'
config.gem 'net-ssh', :lib => 'net/ssh', :version => '2.0.15'
config.gem 'will_paginate', :version => '~> 2.3.11' 
#config.gem 'ssl_requirement'#, :source => 'http://74.207.230.57'

config.gem 'acts_as_singleton', :version => '0.0.3'
config.gem 'aasm', :version => '2.0.2'
config.gem 'carrierwave', :version => '0.4.1'


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
