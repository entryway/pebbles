class CreateProductLargeImages < ActiveRecord::Migration
  
  def self.up
    create_table :product_large_images do |table|
      table.column :parent_id,  :integer
      table.column :content_type, :string
      table.column :filename, :string    
      table.column :thumbnail, :string 
      table.column :size, :integer
      table.column :width, :integer
      table.column :height, :integer
      
      foreign_key :product
    end
  end

  def self.down
    drop_table :product_large_images
  end
end
