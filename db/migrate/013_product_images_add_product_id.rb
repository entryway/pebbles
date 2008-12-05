class ProductImagesAddProductId < ActiveRecord::Migration
  def self.up
    add_column :product_images, :product_id, :integer
  end

  def self.down
    remove_column :product_images, :product_id
  end
end
