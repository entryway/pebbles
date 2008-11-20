class ResetStateOnOrdersToPending < ActiveRecord::Migration
  def self.up
    remove_column :orders, :state
    add_column :orders, :state, :string, :default => 'pending'
  end

  def self.down
  end
end
