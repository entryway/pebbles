class AddShippingSameAsBilling < ActiveRecord::Migration
  def self.up
    add_column  :orders,  :shipping_same_as_billing,  :boolean
  end

  def self.down
    remove_column  :orders,  :shipping_same_as_billing
  end
end
