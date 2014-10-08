module CartBuilder
  def build_variant_cart
    @product = Factory(:product)
    @variant_product = Factory(:product)
    size = Factory(:product_option)
    color = Factory(:product_option, :name => 'color')
    @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
    @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
    @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
    @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
    @variant_product.product_options << [size, color]
    @cart = Cart.create(:name => 'test')
  end

  def build_variant_order_item
    @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
    @order_item = OrderItem.from_cart_item(@cart.cart_items.find_by_product_id(@variant_product.id))
  end

  def build_regular_order_item
    @cart.add_product(@product.id, 1, nil)
    @order_item = OrderItem.from_cart_item(@cart.cart_items.find_by_product_id(@product.id))
  end

  def build_order
    @order = Order.new
    build_variant_order_item
    @order.order_items << @order_item
    build_regular_order_item
    @order.order_items << @order_item
  end


end