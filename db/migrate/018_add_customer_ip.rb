class AddCustomerIp < ActiveRecord::Migration
  def self.up
    add_column :orders, :customer_ip, :string, :limit => 25
  end

  def self.down
    remove_column  :orders,  :customer_ip
  end
end
