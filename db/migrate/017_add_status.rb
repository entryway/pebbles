class AddStatus < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :string, :limit => 20
  end

  def self.down
    remove_column  :orders,  :status
  end
end
