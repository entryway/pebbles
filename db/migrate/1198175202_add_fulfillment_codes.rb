class AddFulfillmentCodes < ActiveRecord::Migration
  def self.up
    create_table :fulfillment_codes do |table|
      integer :item_low
      integer :item_high
      string :code, :limit => 20 
      
      foreign_key :flat_rate_shipping
      
      timestamps!
    end
    
    add_column :quantity_discounts, :product_id, :integer
    remove_column :shipping_rates, :fulfillment_code
  end

  def self.down
  end
end
