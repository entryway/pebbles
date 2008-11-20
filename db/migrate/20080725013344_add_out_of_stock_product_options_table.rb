class AddOutOfStockProductOptionsTable < ActiveRecord::Migration
 def self.up
    create_table :out_of_stock_product_options do
      foreign_key :product
      timestamps!
    end
  end

  def self.down
    drop_table :out_of_stock_product_options
  end
end
