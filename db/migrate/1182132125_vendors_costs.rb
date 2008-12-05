class VendorsCosts < ActiveRecord::Migration
  def self.up
    remove_column :vendors, :shipping_as_cents
    add_column :vendors, :shipping,     :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :vendors, :shipping
    add_column :vendors, :shipping_as_cents,   :integer, :default => 0
  end
end
