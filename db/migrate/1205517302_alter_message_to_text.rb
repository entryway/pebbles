class AlterMessageToText < ActiveRecord::Migration
  def self.up
    remove_column :order_transactions, :message
    add_column :order_transactions, :message, :text
  end

  def self.down
  end
end
