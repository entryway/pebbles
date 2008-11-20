class RenameQuantityDiscounts < ActiveRecord::Migration
  def self.up
    remove_column :quantity_discounts, :quantity
    add_column :quantity_discounts, :quantity_low, :integer, :default => 0
    add_column :quantity_discounts, :quantity_high, :integer, :default => 0
  end

  def self.down
  end
end
