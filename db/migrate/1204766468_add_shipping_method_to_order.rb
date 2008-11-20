class AddShippingMethodToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_method, :string, :limit => 50, :default => ''
  end

  def self.down
    remove_column :orders, :shipping_method
  end
end
