class RenameOrderAddressToAddress < ActiveRecord::Migration
  def self.up
    rename_table :order_addresses, :addresses
  end

  def self.down
  end
end
