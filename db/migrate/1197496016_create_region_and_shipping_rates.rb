class CreateRegionAndShippingRates < ActiveRecord::Migration
  def self.up
    drop_table :shipping_rates
      create_table "regions" do |table|
      string  :name, :limit => 50
    end
    #drop_table "shipping_rates"
    create_table "shipping_rates" do |table|
      string  :name, :limit => 50
      
      boolean   :default_selection
      
      foreign_key :region
    end
    create_table "shipping_providers" do |table|
      string  :name, :limit => 50

      foreign_key :shipping_rate
    end
    create_table "flat_rate_shippings" do |table|
      string  :name, :limit => 50
      
      decimal :base_price
      integer :cost_per_item
      integer :cost_of_subtotal
      integer :cost_per_weight
                  
      integer :item_low
      integer :item_high
      integer :weight_low
      integer :weight_high
      integer :order_total_low
      integer :order_total_high
      
      foreign_key :shipping_provider
 
    end
  end

  def self.down
    drop_table "regions"
  end
end
