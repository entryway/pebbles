class AddAvailableToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :available, :boolean
  end

  def self.down
    remove_column :products, :available
  end
end
