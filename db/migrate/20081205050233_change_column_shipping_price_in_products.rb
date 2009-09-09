class ChangeColumnShippingPriceInProducts < ActiveRecord::Migration
  def self.up
    rename_column :products, :shipping_price, :flat_rate_shipping
  end

  def self.down
    rename_column :products, :flat_rate_shipping, :shipping_price 
  end
end
