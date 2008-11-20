class AddDeliveryStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :delivery_status, :int, :default => 1
  end

  def self.down
    remove_column :orders, :delivery_status
  end
end
