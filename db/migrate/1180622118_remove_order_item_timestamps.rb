class RemoveOrderItemTimestamps < ActiveRecord::Migration
  def self.up
    remove_column  :order_items,  :created_at
    remove_column  :order_items,  :updated_at
  end

  def self.down
    add_column :order_items, :created_at, :timestamp
    add_column :order_items, :updated_at, :timestamp
  end
end
