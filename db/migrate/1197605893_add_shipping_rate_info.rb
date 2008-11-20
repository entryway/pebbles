class AddShippingRateInfo < ActiveRecord::Migration
  def self.up
    add_column :shipping_rates, :fulfillment_code, :string, :limit => 50
  end

  def self.down
  end
end
