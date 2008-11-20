class RemoveSelectedOptions < ActiveRecord::Migration
  def self.up
    remove_column  :order_items,  :selected_options
  end
  
  def self.down
    add_column :order_items, :selected_options, :string
  end
end
