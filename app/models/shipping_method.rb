class ShippingMethod < ActiveRecord::Base
  belongs_to :region
  
  has_many :flat_rate_shippings, :dependent => :destroy, :order => 'order_total_low asc'
  has_many :fulfillment_codes
  
  validates_presence_of :name 
  
  accepts_nested_attributes_for :flat_rate_shippings, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['flat_rate'].blank? }
  
  ##
  # determines whether shipping_method uses flat rate (otherwise uses base rate)                              
  def is_flat_rate?
    flat_rate_shippings.select{|rate| !rate.new_record? }.size > 0
  end
  
  ##
  # flat rate shipping cost
  #
  # @param [Cart, Order] cart_or_order
  # @return [Float] shipping cost
  def flat_rate_shipping_cost(cart_or_order)
    if self.flat_rate_shippings.size > 0
      flat_rate_by_order_total(cart_or_order.sub_total)
    else
      flat_rate_by_base_rate(cart_or_order.line_items)
    end
  end
  
  ##
  # returns the shipping rate of the flat_rate_shippings with the highest order_total_low
  # that is less than or equal to the order_total for the shipping method
  #
  # @param [Float] total order_total
  # @return [Float] flat_rate of the flat_rate_shipping
  def flat_rate_by_order_total(total)
    shipping = self.flat_rate_shippings.ordered_by_total_ranges.find(:last, 
                                                                     :conditions => "order_total_low <= #{total}")
    shipping.flat_rate
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

end


