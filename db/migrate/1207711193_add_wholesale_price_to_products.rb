class AddWholesalePriceToProducts < ActiveRecord::Migration
  def self.up
     add_column :products, :wholesale_price, :decimal, :precision => 8, :scale => 2
  
  end

  def self.down
    remove_column :products, :wholesale_price
  end
end
