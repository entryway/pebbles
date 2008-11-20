class CreateProductOptionsProductsJoin < ActiveRecord::Migration
  def self.up
     create_table :product_options_products, :id => false do |t|
       t.column :product_id, :integer
       t.column :product_option_id, :integer
     end
     add_index :product_options_products, [:product_id]
     add_index :product_options_products, [:product_option_id]

   end

   def self.down
     drop_table :product_options_products
   end
end