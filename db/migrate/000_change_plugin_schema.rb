class ChangePluginSchema < ActiveRecord::Migration
  def self.up
    change_column :plugin_schema_info, :version, :decimal
  end

  def self.down
  end
end
