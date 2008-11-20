class AddTimeStampsToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :updated_at, :datetime
    add_column :order_items, :created_at, :datetime
  end

  def self.down
    remove_column :order_items, :created_at
    remove_column :order_items, :updated_at
  end
end
