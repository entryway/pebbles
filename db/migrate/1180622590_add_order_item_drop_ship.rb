class AddOrderItemDropShip < ActiveRecord::Migration
  def self.up
    add_column :order_items, :drop_ship,  :boolean
    add_column :order_items, :drop_shipping_cost_as_cents,  :integer
  end

  def self.down
    remove_column :order_items, :drop_ship
    remove_column :order_items, :drop_shipping_cost_as_cents
  end
end
