


class OrderBuilder

  def self.build_products(num_products = 1)
    @@products = Array.new
    num_products.times do
      product = OrderFactory.create_product
      @@products << product
    end
  end

  def self.build_order_items(order)
    @@order_items = Array.new
    @@products.each do |product|
      order_item = OrderFactory.create_order_item(:product => product,
                                             :order => order)
      order_item.order = order
      @@order_items << order_item
    end
  end

  def self.build_order(num_products = 1)
    build_products(num_products)

    order = OrderFactory.create_order

    billing_address = OrderFactory.create_address
    shipping_address = OrderFactory.create_address
    order.billing_address = billing_address
    order.shipping_address = shipping_address

    build_order_items(order)
    order
  end




private


end

