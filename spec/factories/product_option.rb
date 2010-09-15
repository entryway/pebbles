Factory.define :product_option do |p|
  p.name                    'size'
  p.selection_type          1
  p.description             'option description'
end

Factory.sequence(:sku) {|n| "sku#{n}"}

Factory.define :product do |f|
  f.sku                { Factory.next(:sku) } 
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