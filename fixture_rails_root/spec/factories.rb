Factory.define(:user) do |u|
  u.login "foo"
  u.email "foo@bar.com"
end

Factory.define(:admin, :parent => :user) do |u|
  u.login "admin"
  u.password "password"
  u.password_confirmation "password"
  u.role "admin"
end

Factory.sequence(:sku) {|n| "A#{n}2345"}
Factory.define(:product) do |p|
  p.name { "Foo" }
  p.sku { Factory.next(:sku) }
end

Factory.define(:category) do |c|
end

Factory.define(:product_image) do |pi|
  pi.filename { File.open(File.join(Rails.root, 'features', 'fixtures', 'test.jpg')) }
end

Factory.define(:order) do |order|
  order.email "hello@world.com"
  order.order_type 1
end
