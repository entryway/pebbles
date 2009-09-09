class AddOrderNumber < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_number, :string
  end

  def self.down
    remove_column :orders, :order_number    
  end

end
