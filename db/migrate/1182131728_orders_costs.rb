class OrdersCosts < ActiveRecord::Migration
  def self.up
    remove_column :orders, :product_cost_as_cents
    add_column :orders, :product_cost,     :decimal, :precision => 8, :scale => 2, :default => 0

    remove_column :orders, :shipping_cost_as_cents
    add_column :orders, :shipping_cost,     :decimal, :precision => 8, :scale => 2, :default => 0

    remove_column :orders, :tax_as_cents
    add_column :orders, :tax,     :decimal, :precision => 8, :scale => 2, :default => 0

    remove_column :orders, :drop_shipping_cost_as_cents
    add_column :orders, :drop_shipping_cost,     :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :orders, :product_cost
    add_column :orders, :product_cost_as_cents,   :integer, :default => 0

    remove_column :orders, :shipping_cost
    add_column :orders, :shipping_cost_as_cents,   :integer, :default => 0

    remove_column :orders, :tax
    add_column :orders, :tax_as_cents,   :integer, :default => 0

    remove_column :orders, :drop_shipping_cost
    add_column :orders, :drop_shipping_cost_as_cents,   :integer, :default => 0
  end
end
