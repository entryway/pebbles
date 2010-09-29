class AddGeneralConfigurationTable < ActiveRecord::Migration
  def self.up
    create_table :general_configurations do |t| 
      t.boolean :inventory_management
    end
  end

  def self.down
    drop_table :general_configurations
  end
end
