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
  f.inventory          10
end