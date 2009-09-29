
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :variant
  
  has_many :option_selections, 
           :class_name => 'CartItemSelection'
  
  cattr_accessor :discounted
 
  def price
    # take quantity discount into consideration
    # self.discounted = false
    # unless @price
    #   # TODO: if wholesale module 
    #   @price = QuantityDiscount.discounted_price(self)
    #   self.discounted = true if @price != product.price
    # end
    # @price
    self.discounted = false
    price = self.product.price

    # include selection adjustments
    option_selections.each do |option|
      if option.product_option_selection.price_adjustment
        price += option.product_option_selection.price_adjustment
      end
    end
    
    price
  end

  class << self

    # add the product to the cart with any accessories selected
    def add_product(product_id, quantity, options)
      Cart.transaction do
        options ||= Array.new
        product = Product.find(product_id)
        variant = product.find_variant_by_selection_ids(options)
        cart_item = CartItem.find_product_with_options(cart, product_id, options)
        add_to_cart(cart, cart_item, product_id, quantity, options)
      end
    end
    
    def add_to_cart(cart, cart_item, product_id, quantity, options)
      if cart_item
        # increase quantity, exists
        cart_item.quantity += CartItem.valid_quantity(quantity)
        cart_item.save!
      else
        # product does not exist with those options, add
        cart_item = CartItem.new
        cart_item.product_id = product_id
        cart_item.quantity = CartItem.valid_quantity(quantity)
        cart.cart_items << cart_item

       if options 
          options.each do |option|
            id = option.to_i
            po = ProductOptionSelection.find(id)
            cart_item_selection = CartItemSelection.new
            cart_item_selection.cart_item = cart_item
            cart_item_selection.product_option_selection = po
            cart_item.option_selections << cart_item_selection
          end
        end
      end
    end
    
  # does the product with the exact options already exist?
    def find_product_with_options(cart, product_id, options)
      cart_items = cart.cart_items.find(:all,
                            :conditions => { :product_id => product_id},
                            :include => :option_selections)
      unless cart_items.nil?
        # go through cart_items

        for cart_item in cart_items
          has_all_selections = true
          #check each option
          for option in options
            has_selection = false

            # if the option is the same as the cart_items option then it has it
            for option_selection in cart_item.option_selections
               if option_selection.product_option_selection_id == option.to_i
                 has_selection = true
               end
            end
            # if it doesn't have the selection then it fails as a matching cart_item
            unless has_selection
              has_all_selections = false
              break
            end
          end
          # otherwise it has matched all selections and it is good to return
          if has_all_selections
            return cart_item
          end
        end
        # no cart items have matched so it return nil and we will create a new one.
        return nil
      end
    end
  
    # check the quantity passed and ensure it is
    # valid or greater then 0
    def valid_quantity(quantity)
       begin
          quantity = quantity.to_i
        rescue
          # if invalid number, just default to 1
          quantity = 1
        end
        # default to one
        quantity <= 0 ? 1 : quantity
    end
    
    private
    
  end
end
