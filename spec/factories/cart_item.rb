Factory.define :cart_item do |f|
  f.cart Factory(:cart)
  f.product Factory(:product)
  f.quantity 1
  f.options_selections Factory(:product_option)
 end
