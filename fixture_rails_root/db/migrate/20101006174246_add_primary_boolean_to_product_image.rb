class AddPrimaryBooleanToProductImage < ActiveRecord::Migration
  def self.up
    add_column :product_images, :primary, :boolean
  end

  def self.down
    remove_column :product_images, :primary
  end
end
