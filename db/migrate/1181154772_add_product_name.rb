class AddProductName < ActiveRecord::Migration
  def self.up
    add_column :order_items, :product_name,     :string, :limit => 50
  end

  def self.down
    remove_column :order_items, :product_name
  end
end
