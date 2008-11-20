class AddProductOptionSelectionIdToImages < ActiveRecord::Migration
  def self.up
    add_column :product_option_selection_images,:product_option_selection_id, :integer
  end

  def self.down
    remove_column :product_option_selection_images, :product_option_selection_id
  end
end
