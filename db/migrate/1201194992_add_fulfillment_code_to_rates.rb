class AddFulfillmentCodeToRates < ActiveRecord::Migration
  def self.up
    add_column :shipping_rates, :fulfillment_code, :string
  end

  def self.down
    remove_column :shipping_rates, :fulfillment_code, :string
  end
end
