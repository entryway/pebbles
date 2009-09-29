# TODO: The duplicate nature of the order and cart is silly
# should be extracted/abstracted out someway to share common impl
class Cart < ActiveRecord::Base
  include ShippingCalculations
  
  has_many :cart_items
  has_many :products, :through => :cart_items
  
  validates_length_of :name, :in => 1..40
  
  attr_accessor :shipping_method_id
  
  def line_items
    cart_items
  end
  
  # order cart items
  def ordered_cart_items
    cart_items.find(:all, :order => 'product_id')
  end
  
  # subtotal price
  def sub_total
   cart_items.inject(0) {|sum, n| n.price * n.quantity + sum}
  end
  
  # shipping totals
  def shipping_total(shipping_method)
    shipping_method_id = shipping_method
    calculate_flat_rate_shipping
  end
 
  def calculate_flat_rate_shipping(region, shipping_method)
    @price = 0
    unless self.free_shipping
      if shipping_method && shipping_method.flat_rate_shipping
        @price = shipping_method.flat_rate_shipping.base_price;
        per_item = shipping_method.flat_rate_shipping.cost_per_item;
        cart_items.each do |cart_item| 
          @price += per_item * cart_item.quantity 
        end 
        @price -= per_item # compensate for first item
      end
    end
    @price
  end
  
  # calculate total price
  def grand_total(shipping_total)
     sub_total + shipping_total - self.promo_discount
  end
  
  # calculate total price in cents
  def grand_total_in_cents(shipping_total)
     (sub_total + shipping_total) * 100
  end

  # add the product to the cart with any accessories selected
  def add_product(product_id, quantity, options)
    Cart.transaction do
      options ||= Array.new
      product = Product.find(product_id)
      variant = product.find_variant_by_selection_ids(options)
      cart_item = find_product_with_options(cart, product_id, options)
      add_to_cart(cart, cart_item, product_id, quantity, options)
    end
  end

  def find_product_or_variant(product, variant)
    cart_items.find(:first, :conditions => { :product_id => product, :variant_id => variant })
  end
  
end 
