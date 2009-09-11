

#puts config.load_paths

config.gem 'collectiveidea-awesome_nested_set',
           :lib => 'awesome_nested_set',  :source => 'http://gems.github.com'
config.load_paths += %W(#{Rails.root}/vendor/plugins/pebbles/app/lib)
config.load_paths += %W(#{Rails.root}/vendor/plugins/pebbles/app/notifiers)
