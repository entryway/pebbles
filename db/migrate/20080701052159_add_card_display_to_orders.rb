class AddCardDisplayToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :credit_card_display, :string, :limit => 20
  end

  def self.down
    remove_column :orders, :credit_card_display
  end
end
