class ModifyDefaultAvailableValue < ActiveRecord::Migration
  def self.up
    remove_column :products, :available
    add_column :products, :available, :boolean, :default => true
  end

  def self.down
  end
end
