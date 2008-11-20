class AddCompanyToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :company, :string, :limit => 50, :default => ''
  end

  def self.down
    remove_column :orders, :company
  end
end
