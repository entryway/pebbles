class AddBusinessName < ActiveRecord::Migration
  def self.up
    add_column :orders, :business, :string, :limit => 50
  end

  def self.down
    remove_column :orders, :business 
  end
end
