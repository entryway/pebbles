class ChangeFlatRateRefToShippingMethodId < ActiveRecord::Migration
  def self.up
    rename_column :fulfillment_codes, :flat_rate_shipping_id, :shipping_method_id
  end

  def self.down
    rename_column :fulfillment_codes, :shipping_method_id, :flat_rate_shipping_id
  end
end
