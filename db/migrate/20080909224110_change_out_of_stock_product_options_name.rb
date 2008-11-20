class ChangeOutOfStockProductOptionsName < ActiveRecord::Migration
  def self.up
    rename_table :out_of_stock_product_options, :out_of_stock_options
    rename_table :out_of_stock_product_option_selections, :out_of_stock_option_selections
    rename_column :out_of_stock_option_selections, :out_of_stock_product_option_id, :out_of_stock_option_id
  end

  def self.down
    rename_column :out_of_stock_option_selections, :out_of_stock_option_id, :out_of_stock_product_option_id
    rename_table :out_of_stock_option_selections, :out_of_stock_product_option_selections
    rename_table :out_of_stock_options, :out_of_stock_product_options
  end
end
