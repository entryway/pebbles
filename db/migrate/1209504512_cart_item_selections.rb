class CartItemSelections < ActiveRecord::Migration
  def self.up
    create_table :cart_item_selections do |table|
        foreign_key :cart_item
        foreign_key :product_option_selection
    end
  end

  def self.down
  end
end
