class AddAddressesBackToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_address_id, :integer
    add_column :orders, :billing_address_id, :integer
    remove_column :order_addresses, :order_id
  end

  def self.down
    remove_column :orders, :shipping_address_id
    remove_column :orders, :billing_address_id
    add_column :order_addresses, :order_id, :integer
  end
end
