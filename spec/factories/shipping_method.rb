Factory.define :shipping_method do |m|
  m.name               "UPS Ground"     
  m.default_selection    true
  m.base_price           5.00
  m.cost_per_item        1.00
end
