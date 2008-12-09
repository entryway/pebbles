require 'factory_girl'

Factory.define :product do |f|
  f.sku                'sku'
  f.name               'product1'
  f.description        'description for product 1'
  f.weight             1
  f.shipping_type      ShippingType::DEFAULT_SHIPPING
  f.available          true
  f.price              5.50
  f.admin_notes        'adminnotes'
end

Factory.define :vendor do |f|
  f.name              'vendor1'
  f.zipcode           '24091'
  f.shipping_type     ShippingType::FREE_SHIPPING
end

Factory.define :product_accesory do |f|
  f.price_adjustment  '1.00'
end

