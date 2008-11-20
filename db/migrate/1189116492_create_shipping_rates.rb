class CreateShippingRates < ActiveRecord::Migration
  def self.up
    create_table :shipping_rates do |t|
      t.column :rate,       :decimal, :precision => 8, :scale => 2, :default => 0.0
      t.column :item_low,   :integer
      t.column :item_high,  :integer
      t.column :type,       :string, :limit => 40
    end
  end

  def self.down
    drop_table :shipping_rates
  end
end
