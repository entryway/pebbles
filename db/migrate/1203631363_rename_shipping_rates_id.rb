class RenameShippingRatesId < ActiveRecord::Migration
  def self.up
    rename_column :flat_rate_shippings, :shipping_provider_id, :shipping_method_id
  end

  def self.down
  end
end
