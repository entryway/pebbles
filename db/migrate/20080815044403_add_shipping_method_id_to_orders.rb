class AddShippingMethodIdToOrders < ActiveRecord::Migration
   def self.up
    add_column :orders, :shipping_method_id, :int
  end

  def self.down
    remove_column :orders, :shipping_method
  end
end