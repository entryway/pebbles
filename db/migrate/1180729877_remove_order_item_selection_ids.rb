class RemoveOrderItemSelectionIds < ActiveRecord::Migration
  def self.up
      remove_column :order_item_selections, :option_selection_id
      remove_column :order_item_selections, :product_option_id
      add_column :order_item_selections, :sku, :string
  end

  def self.down
    add_column :order_item_selections, :option_selection_id, :integer
    add_column :order_item_selections, :product_option_id, :integer 
    remove_column :order_item_selections, :sku
  end
end
