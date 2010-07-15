class PebblesChangeOrderitemColumnLength < ActiveRecord::Migration
  def self.up
    change_column :order_items, :product_name, :string, :limit => 255
  end

  def self.down
  end
end
