class ShippingMethod < ActiveRecord::Base
  belongs_to :region

  has_many :flat_rate_shippings, :dependent => :destroy
  has_many :fulfillment_codes

  validates_presence_of :name

  accepts_nested_attributes_for :flat_rate_shippings, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['flat_rate'].blank? }

  ##
  # Determines whether shipping_method uses base rate
  #
  def is_base_rate?
    !(GeneralConfiguration.shipping_calculated_by_weight? || is_order_range_flat_rated?)
  end
  
  def is_order_range_flat_rated?
    flat_rate_shippings.select{|rate| !rate.new_record? }.size > 0
  end

  ##
  # Flat rate shipping cost
  #
  # @param [Cart, Order] cart_or_order A cart or order that has the same interface.
  # @return [Float] shipping cost
  def flat_rate_shipping_cost(cart_or_order)
    if self.flat_rate_shippings.size > 0
      if GeneralConfiguration.shipping_calculated_by_weight?
        weight_total = cart_or_order.shipping_weight_total
        flat_rate_by_weight_total(weight_total)
      else
        order_total = order_total_minus_freely_shipped_products(cart_or_order)
        flat_rate_by_order_total(order_total)
      end
    else
      flat_rate_by_base_rate(cart_or_order.line_items)
    end
  end

private

  ##
  # Returns the shipping rate of the flat rate shippings for flat rates between
  # a low and high order total.
  #
  # @param [Float] total The order total to determine the shipping costs from.
  # @return [Float] flat_rate of the flat_rate_shipping
  def flat_rate_by_order_total(total)
    shipping = self.flat_rate_shippings.ordered_by_total_ranges.find(:last,
                                                                     :conditions =>
                                                                      "order_total_low <= #{total}")
    shipping.nil? ? 0 : shipping.flat_rate
  end

  def flat_rate_by_weight_total(weight)
    flat_rate_shippings.ordered_by_weight_ranges(weight).last.flat_rate
  end

  ##
  # flat rate shipping cost by base and per item rate
  #
  # @param [Array<OrderItem, CartItem>] line_items items to iterate for per item cost
  # @return [Float] shipping cost
  def flat_rate_by_base_rate(line_items)
    price = self.base_price
    per_item = self.cost_per_item
    line_items.each do |line_item|
      price += per_item * line_item.quantity
    end
    price -= per_item # compensate for first item
  end

  ##
  # Determines the order total not counting any products that have
  # been marked free to ship.
  #
  # @param [Cart, Order] cart_or_order The cart_or_order to determine total.
  # @return [Float] The total minus freely shipping products.
  def order_total_minus_freely_shipped_products(cart_or_order)
    total = cart_or_order.sub_total
    cart_or_order.line_items.each do |line_item|
      product = line_item.product
      if product.free_shipping
        total -= (product.price * line_item.quantity)
      end
    end
    total
  end

end


