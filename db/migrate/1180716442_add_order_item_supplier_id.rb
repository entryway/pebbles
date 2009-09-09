class AddOrderItemSupplierId < ActiveRecord::Migration
  def self.up
    add_column :order_items, :supplier_id,  :integer
  end

  def self.down
    remove_column :order_items, :supplier_id
  end
end
