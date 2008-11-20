class AddOutOfStockProductOptionSelectionsTable < ActiveRecord::Migration
  def self.up
    create_table :out_of_stock_product_option_selections do
      foreign_key :out_of_stock_product_option
      foreign_key :product_option_selection
      timestamps!
    end
  end

  def self.down
    drop_table :out_of_stock_product_option_selections
  end
end
