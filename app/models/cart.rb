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
    Inventory.new.validate_cart(self)
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
    calculate_shipping_costs
  end
  
  # calculate total price
  def grand_total(shipping_total)
     product_total + shipping_total + tax_total - self.promo_discount
  end
  
  # calculate total price in cents
  def grand_total_in_cents(shipping_total)
     (sub_total + shipping_total) * 100
  end

  ##
  # Add the product to the cart with any options selected.
  #
  # @param [Integer] product_id Id of product to add. # TODO change to product
  # @param [Integer] quantity The number of products to add. 
  # @param [Array] options List of options that were selected for the product. 
  # @return [CartItem] The newly created or existing cart item. 
  def add_product(product_id, quantity, options)
    cart_item = nil
    Cart.transaction do
      options ||= Array.new
      product = Product.find(product_id)
      variant = product.find_variant_by_selection_ids(options)
      cart_item = find_product_or_variant(product, variant)
      cart_item = add_to_cart(cart_item, product, quantity, variant)
    end
    cart_item
  end
  
  ##
  # returns the cart item that matches the product or variant
  #
  # @param [Product] product the product to match
  # @param [<Variant, nil>] variant the variant if the product has variants otherwise nil
  #
  # @return [CartItem] the matching cart_item
  def find_product_or_variant(product, variant)
    cart_items.find(:first, :conditions => { :product_id => product, :variant_id => variant })
  end
  

  def tax_total
    tax = 0
    tax = TaxRate.calculate_tax(billing_state, sub_total) if billing_state
    tax
  end

private

  ##
  # Add a cart item to the cart. 
  #
  # @param [CartItem] cart_item An existing cart item or a new one will be created.
  # @param [Product] product The product to add to the cart.
  # @param [Integer] quantity The number of products to add.
  # @param [Variant] variant The product variant connected to the product.
  # @return [CartItem] The newly created or exiting cart item.
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
    cart_item
  end
  

end 
