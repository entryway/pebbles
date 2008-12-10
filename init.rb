config.gem "calendar_date_select"
config.gem 'ruport'
require 'pebbles/asset_copier'

if RAILS_ENV == "development"
  Pebbles::AssetCopier.copy "pebbles"
elsif RAILS_ENV == "production"
  Pebbles::AssetCopier.warn "pebbles"
end