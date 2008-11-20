class AddOrderTypeToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :type, :integer
  end

  def self.down
    remove_column :orders, :type, :integer
  end
end
