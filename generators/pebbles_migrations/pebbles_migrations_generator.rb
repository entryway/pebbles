require 'rails_generator'

class PebblesMigrationsGenerator < Rails::Generator::Base
  # We use the sleep method to maintain
  # unique migration timestamps.

  def manifest
    record do |m|
      
      target_dir = "db/migrate"

      m.migration_template("migrations/pebbles_initial_schema_load.rb", target_dir, :migration_file_name => "pebbles_initial_schema_load")
      m.sleep(1)

      m.migration_template("migrations/pebbles_create_table_variants.rb", target_dir, :migration_file_name => "pebbles_create_table_variants")
      m.sleep(1)

      m.migration_template("migrations/pebbles_create_table_variant_selections.rb", target_dir, :migration_file_name => "pebbles_create_table_variant_selections")
      m.sleep(1)
      
      m.migration_template("migrations/pebbles_add_general_configuration_table.rb", target_dir, :migration_file_name => "pebbles_add_general_configuration_table")
      m.sleep(1)

      m.migration_template("migrations/pebbles_add_variant_image_thumbnail_and_large_tables.rb", target_dir, :migration_file_name => "pebbles_add_variant_image_thumbnail_and_large_tables")
      m.sleep(1)

      m.migration_template("migrations/pebbles_add_category_icon_table.rb", target_dir, :migration_file_name => "pebbles_add_category_icon_table")
      m.sleep(1)

      m.migration_template("migrations/pebbles_add_category_icon_hovers_table.rb", target_dir, :migration_file_name => "pebbles_add_category_icon_hovers_table")
      m.sleep(1)
      
      m.migration_template("migrations/pebbles_change_orderitem_column_length.rb", target_dir, :migration_file_name => "pebbles_change_orderitem_column_length")
      m.sleep(1)

      m.migration_template("migrations/pebbles_create_slugs.rb", target_dir, :migration_file_name => "pebbles_create_slugs")
      m.sleep(1)

      m.migration_template("migrations/pebbles_add_no_shipping_flag_to_products.rb", target_dir, :migration_file_name => "pebbles_add_no_shipping_flag_to_products")
    end 
  end
end
