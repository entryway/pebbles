class AddGiftNoteToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :gift_note, :text
  end

  def self.down
    remove_column :orders, :gift_note
  end
end
