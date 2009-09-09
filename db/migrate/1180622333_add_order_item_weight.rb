class AddOrderItemWeight < ActiveRecord::Migration
  def self.up
    add_column :order_items, :weight, :decimal, :precision => 8, :scale => 2, :default => 0.0
    add_column :order_items, :adjusted_weight, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def self.down
    remove_column :order_items, :weight
    remove_column :order_items, :adjusted_weight
  end
end
