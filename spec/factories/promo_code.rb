
Factory.define :promo_code do |promo|
  promo.name     'test promo code'
  promo.code     'some_code'
  promo.minimum_order_amount 0.00
  promo.free_shipping  false
end
