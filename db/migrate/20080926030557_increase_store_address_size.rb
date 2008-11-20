class IncreaseStoreAddressSize < ActiveRecord::Migration
  def self.up
    change_column :stores, :address, :string, :limit => 200
  end

  def self.down
  end
end
