class AddAdminNotesToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_notes, :text
    add_column :order_addresses, :country, :string, :limit => 50
  end

  def self.down
  end
end
