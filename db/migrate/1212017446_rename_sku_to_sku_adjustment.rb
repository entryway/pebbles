class RenameSkuToSkuAdjustment < ActiveRecord::Migration
  def self.up
    rename_column :order_item_selections, :sku, :sku_adjustment
  end

  def self.down
    rename_column :order_item_selections, :sku_adjustment, :sku
  end
end
