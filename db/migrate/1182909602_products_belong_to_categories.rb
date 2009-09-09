class ProductsBelongToCategories < ActiveRecord::Migration
  def self.up
    rename_column :categories_vendors, :vendor_id, :product_id
    rename_table :categories_vendors, :categories_products
  
    say_with_time 'Linking 4th sample' do
        execute "INSERT INTO categories_products (product_id, category_id) VALUES ('3', '2');"
    end
  end

  def self.down
    rename_column :categories_vendors, :product_id, :vendor_id
    rename_table :categories_products, :categories_vendors
  end
end
