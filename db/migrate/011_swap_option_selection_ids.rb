class SwapOptionSelectionIds < ActiveRecord::Migration
  def self.up
    remove_column :product_options, :option_selection_id
    add_column :option_selections, :product_option_id, :integer
  end

  def self.down
    add_column :product_options, :option_selection_id, :integer
    remove_column :option_selections, :product_option_id
  end
end