
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :variant
  
  has_many :option_selections, 
           :class_name => 'CartItemSelection'
           
  validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0 
  
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
    if variant
      self.variant.price 
    else
      self.product.price
    end
  end

 class << self
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
