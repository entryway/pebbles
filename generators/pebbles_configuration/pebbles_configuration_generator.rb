require 'rails_generator'

class PebblesConfigurationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.file "config/config.yml", "config/config.yml"
      m.file "config/initializers/load_config.rb", "config/initializers/load_config.rb"
    end
  end
end
