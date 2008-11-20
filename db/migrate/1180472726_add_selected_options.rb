class AddSelectedOptions < ActiveRecord::Migration
  def self.up
    add_column :order_items, :selected_options, :string
  end
  
  def self.down
    remove_column  :order_items,  :selected_options
  end
end
