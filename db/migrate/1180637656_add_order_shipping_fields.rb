class AddOrderShippingFields < ActiveRecord::Migration
  def self.up
    add_column :orders, :drop_shipping_cost_as_cents,  :integer
    add_column :orders, :shipment_weight_total,  :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def self.down
    remove_column :orders, :drop_shipping_cost_as_cents
    remove_column :orders, :shipment_weight_total
  end
end
