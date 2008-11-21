class AddColumnShippingPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :shipping_price, :decimal
    add_column :products, :warranty, :string
  end

  def self.down
    remove_column :products, :shipping_price
    remove_column :products, :warranty
  end
end
