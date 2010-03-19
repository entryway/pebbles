class AddNoShippingFlagToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :free_shipping, :boolean, :default => false
  end

  def self.down
  end
end
