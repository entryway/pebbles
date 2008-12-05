class AddTimestamps < ActiveRecord::Migration
  def self.up
    add_column :orders, :created_at, :timestamp
    add_column :orders, :updated_at, :timestamp
  end

  def self.down
    remove_column  :orders,  :created_at
    remove_column  :orders,  :updated_at
  end
end
