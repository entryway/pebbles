
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :product_accessory
  
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
    option_selections.each do |option|
      if option.product_option_selection.price_adjustment
        price += option.product_option_selection.price_adjustment
      end
    end
    if product_accessory
      price = product_accessory.price
    end
    price
  end
  
  class << self 
    
    # add the product to the cart with any accessories selected
    def add_product(cart, product_id, quantity, options, accessories)
      options ||= Array.new
      cart_item = CartItem.find_product_with_options(cart, product_id, options)
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
      add_accessories(cart, accessories, product_id) 
    end
    
    # does the product with the exact options already exist?
    def find_product_with_options(cart, product_id, options, product_accessory = nil)
      cart_items = cart.cart_items.find(:all,
                            :conditions => { :product_id => product_id, 
                                             :product_accessory_id => product_accessory },
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
    
    def add_accessories(cart, accessories, product_id) 
      for accessory in accessories
        add_accessory(cart, accessory, product_id)
      end   
    end   
    
    def add_accessory(cart, accessory, product_id)
      product_accessory = ProductAccessory.find(:first, :conditions => {
                                                          :accessory_id => accessory.id, 
                                                          :product_id  => product_id })
      
     
      cart_item = CartItem.find_product_with_options(cart, product_id, nil, product_accessory)
      if cart_item
        # increase quantity, exists
        cart_item.quantity += 1
        cart_item.save!
      else
        # product does not exist add 1
        cart_item = CartItem.new
        cart_item.product_id = accessory.id
        cart_item.product_accessory_id = product_accessory.id
        cart_item.quantity = 1
        cart.cart_items << cart_item
      end
    end
    
  end
end
