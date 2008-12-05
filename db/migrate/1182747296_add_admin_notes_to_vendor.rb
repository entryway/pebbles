class AddAdminNotesToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :admin_notes,  :text
  end

  def self.down
    remove_column :vendors, :admin_notes
  end
end
