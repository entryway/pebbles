class AddQuanityDiscounts < ActiveRecord::Migration
  def self.up
    create_table :quantity_discounts do |table|
      integer :quantity
      decimal :price_per_product, :precision => 8, :scale => 5, :default => 0.0
    end
  end

  def self.down
  end
end
