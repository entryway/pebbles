require 'factory_girl'



Factory.define :vendor do |f|
  f.name              'vendor1'
  f.zipcode           '46219'
  f.shipping_type     ShippingType::FREE_SHIPPING
end

Factory.define :product_accesory do |f|
  f.price_adjustment  '1.00'
end

Factory.define :configuration do |f|
  f.shipping_type  ShippingType::REAL_TIME_SHIPPING
end

Factory.define :address do |f|
  f.address_1       "nowhere"
  f.city            "Floyd"
  f.postal_code     "24091"
  f.is_shipping     true
  f.country         "US"
  f.state           "VA"
end

