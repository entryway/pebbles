class OrderItemsPriceShipping < ActiveRecord::Migration
  def self.up
    remove_column :order_items, :price_as_cents
    add_column :order_items, :price,     :decimal, :precision => 8, :scale => 2, :default => 0

    remove_column :order_items, :adjusted_price_as_cents
    add_column :order_items, :adjusted_price,     :decimal, :precision => 8, :scale => 2, :default => 0

    remove_column :order_items, :drop_shipping_cost_as_cents
    add_column :order_items, :drop_shipping_cost,     :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :order_items, :price
    add_column :order_items, :price_as_cents,   :integer, :default => 0

    remove_column :order_items, :adjusted_price
    add_column :order_items, :adjusted_price_as_cents,   :integer, :default => 0

    remove_column :order_items, :drop_shipping_cost
    add_column :order_items, :drop_shipping_cost_as_cents,   :integer, :default => 0
  end
end
