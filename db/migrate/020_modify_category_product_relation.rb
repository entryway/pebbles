class ModifyCategoryProductRelation < ActiveRecord::Migration
  def self.up
    rename_table :categories_products, :categories_suppliers
    rename_column :categories_suppliers, :product_id, :supplier_id

    add_index :categories_suppliers, [:category_id]
    add_index :categories_suppliers, [:supplier_id]
   end

  def self.down
    rename_table :categories_suppliers, :categories_products
    rename_column :categories_products, :supplier_id, :supplier_id
    
    add_index :categories_products, [:category_id]
    add_index :categories_products, [:product_id]  
  end
end