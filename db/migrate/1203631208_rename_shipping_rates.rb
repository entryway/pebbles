class RenameShippingRates < ActiveRecord::Migration
  def self.up
    rename_table :shipping_rates, :shipping_methods
  end

  def self.down
  end
end
