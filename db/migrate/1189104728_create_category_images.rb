class CreateCategoryImages < ActiveRecord::Migration
  
  def self.up
    create_table :category_images do |table|
      integer :parent_id
      string :content_type
      string :filename 
      string :thumbnail
      integer :size
      integer :width
      integer :height
      integer :category_id
    end
  end

  def self.down
    drop_table :category_images
  end
end