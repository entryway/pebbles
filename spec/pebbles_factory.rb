require 'factory_girl'

Factory.sequence :sku do |n|
 "sku#{n}"
end

Factory.define :product do |f|
  f.sku                 { Factory.next(:sku) } 
  f.name               'product1'
  f.description        'description for product 1'
  f.weight             1
  f.length             20
  f.width              10
  f.height             10
  f.shipping_type      ShippingType::DEFAULT_SHIPPING
  f.available          true
  f.price              5.50
  f.admin_notes        'adminnotes'
end

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

Factory.define :tax_rate do |f|
  f.rate            0.05
  f.state           'VA'
end

Factory.define :address do |f|
  f.address_1       "nowhere"
  f.city            "Floyd"
  f.postal_code     "24091"
  f.is_shipping     true
  f.country         "US"
  f.state           "VA" 
end
