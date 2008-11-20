class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column "users", :role, :string, :limit => 20
    add_index "users", :role
  end

  def self.down
    remove_column "users", :role
  end
end