class CartItemSelection < ActiveRecord::Base
  belongs_to :cart_item
  belongs_to :product_option_selection
end