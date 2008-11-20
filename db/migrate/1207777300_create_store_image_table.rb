class CreateStoreImageTable < ActiveRecord::Migration
  def self.up
     create_table :store_images do |table|
      table.column :parent_id,  :integer
      table.column :content_type, :string
      table.column :filename, :string    
      table.column :thumbnail, :string 
      table.column :size, :integer
      table.column :width, :integer
      table.column :height, :integer
      table.column :store_id, :integer
    end
  end

  def self.down
  end
end
