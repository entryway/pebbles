

#puts config.load_paths

config.gem 'collectiveidea-awesome_nested_set',
           :lib => 'awesome_nested_set',  :source => 'http://gems.github.com'

ActiveSupport::Dependencies.load_paths << RAILS_ROOT+ "/vendor/plugins/pebbles/app/lib"
ActiveSupport::Dependencies.load_paths << RAILS_ROOT+ "/vendor/plugins/pebbles/app/notifiers"

%w(controllers helpers lib models notifiers views ).each  do |path| 
  ActiveSupport::Dependencies.load_once_paths.delete File.join(File.dirname(__FILE__), 'app', path) 
end
ActiveSupport::Dependencies.load_once_paths.delete File.join(File.dirname(__FILE__), 'lib')
