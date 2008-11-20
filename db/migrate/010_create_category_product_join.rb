class CreateCategoryProductJoin < ActiveRecord::Migration
  def self.up
     create_table :categories_products, :id => false do |t|
       t.column :product_id, :integer
       t.column :category_id, :integer
     end
     add_index :categories_products, [:category_id]
     add_index :categories_products, [:product_id]

     add_column :categories, :name, :string
   end

   def self.down
     drop_table :categories_products
     remove_column :categories, :name
   end
end