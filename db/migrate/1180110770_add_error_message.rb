class AddErrorMessage < ActiveRecord::Migration
  def self.up
    add_column :orders, :error_message, :string, :limit => 255
  end

  def self.down
    remove_column  :orders,  :error_message
  end
end
