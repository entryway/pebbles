class AddItemAndAuctionIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :ebay_item_number, :string, :limit => 30
    add_column :orders, :ebay_auction_id, :string, :limit => 30
  end

  def self.down
    remove_column :orders, :ebay_item_number
    remove_column :orders, :ebay_auction_id
  end
end
