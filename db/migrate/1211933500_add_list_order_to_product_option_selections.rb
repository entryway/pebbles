class AddListOrderToProductOptionSelections < ActiveRecord::Migration
  def self.up
    add_column :product_option_selections, :list_order, :integer, :default => 99
  end

  def self.down
    remove_column :product_option_selections, :list_order
  end
end
