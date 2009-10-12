# TODO: The duplicate nature of the order and cart is silly
# should be extracted/abstracted out someway to share common impl
class Cart < ActiveRecord::Base
  include ShippingCalculations
  
  has_many :cart_items, :order => 'product_id, variant_id'
  has_many :products, :through => :cart_items
  
  validates_length_of :name, :in => 1..40
  
  accepts_nested_attributes_for :cart_items
  
  attr_accessor :shipping_method_id
  
  def validate
    if GeneralConfiguration.instance.inventory_management?
      cart_items.each do |cart_item|
        unless cart_item.validate_quantity
          errors.clear
          if product_total <= 0
            errors.add_to_base("Our apologies, all items in your cart were no longer available.")
          else
            errors.add_to_base("The quantity of certain items in your cart exceeded availability" +
                                " and were adjusted")
          end
        end
      end
    end
  end
  
  def line_items
    cart_items
  end
  
  # order cart items
  def ordered_cart_items
    cart_items.find(:all, :order => 'product_id')
  end
  
  def product_total
    cart_items.inject(0) {|sum, n| n.price * n.quantity + sum}
  end

  def sub_total
    product_total - promo_discount
  end
  
  # shipping totals
  def shipping_total(shipping_method)
    self.shipping_method_id = shipping_method
    calculate_flat_rate_shipping
  end
  
  # calculate total price
  def grand_total(shipping_total)
     product_total + shipping_total + tax_total - self.promo_discount
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
      cart_item = find_product_or_variant(product, variant)
      add_to_cart(cart_item, product, quantity, variant)
    end
  end

  def find_product_or_variant(product, variant)
    cart_items.find(:first, :conditions => { :product_id => product, :variant_id => variant })
  end
  
  def add_to_cart(cart_item, product, quantity, variant)
    if cart_item
      # increase quantity, exists
      cart_item.quantity += CartItem.valid_quantity(quantity)
      cart_item.save!
    else
      # cart_item does not exist with this product/variant, add
      cart_item = CartItem.new
      cart_item.product_id = product.id
      cart_item.variant_id = variant.id if variant
      cart_item.quantity = CartItem.valid_quantity(quantity)
      cart_items << cart_item
    end
  end
  
  def tax_total
    tax = 0
    tax = TaxRate.calculate_tax(billing_state, sub_total) if billing_state
    tax
  end
  
  def inventory_remaining(product, variant = nil)
    if GeneralConfiguration.instance.inventory_management? 
      inventory = (variant || product).inventory 
      existing_cart_item = find_product_or_variant(product, variant)
      inventory -= existing_cart_item.quantity if existing_cart_item
      inventory
    else
      nil
    end
  end

end 
