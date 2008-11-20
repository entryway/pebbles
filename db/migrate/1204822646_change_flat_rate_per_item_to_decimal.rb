class ChangeFlatRatePerItemToDecimal < ActiveRecord::Migration
  def self.up
    remove_column :flat_rate_shippings, :cost_per_item
    add_column :flat_rate_shippings, :cost_per_item, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
  end
end
