class SuppliersAreNowVendors < ActiveRecord::Migration
  def self.up
    rename_table :suppliers, :vendors
    rename_table :categories_suppliers, :categories_vendors
    rename_column :categories_vendors, :supplier_id, :vendor_id
    rename_column :products, :supplier_id, :vendor_id
  end

  def self.down
    rename_table :vendors, :suppliers
    rename_table :categories_vendors, :categories_suppliers
    rename_column :categories_vendors, :vendor_id, :supplier_id
    rename_column :products, :vendor_id, :supplier_id
  end
end
