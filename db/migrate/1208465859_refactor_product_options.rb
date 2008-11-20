class RefactorProductOptions < ActiveRecord::Migration
  def self.up
    rename_table :product_options, :options
    rename_table :product_options_products, :product_options   
  end

  def self.down
  end
end
