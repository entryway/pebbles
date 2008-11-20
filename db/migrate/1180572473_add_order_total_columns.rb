class AddOrderTotalColumns < ActiveRecord::Migration
  def self.up
    add_column :orders, :product_cost_as_cents, :integer
    add_column :orders, :shipping_cost_as_cents, :integer
    add_column :orders, :tax_as_cents, :integer
  end

  def self.down
    remove_column :orders, :product_cost_as_cents
    remove_column :orders, :shipping_cost_as_cents
    remove_column :orders, :tax_as_cents
  end
end
