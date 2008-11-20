class IncreaseStateSize < ActiveRecord::Migration
  def self.up
    remove_column :addresses, :state
    add_column :addresses, :state, :string, :limit => 50
  end

  def self.down
  end
end
