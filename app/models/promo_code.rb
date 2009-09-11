
class PromoCode < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :code
  
  attr_accessor :message 
  
  SUCCESS_MESSAGE = "Promo Code successfully applied, enjoy."
  NOT_APPLIED_MESSAGE = "Promo Code not applied."
  INVALID_MESSAGE = "This is not a valid promo code, please check and reapply."
  
  # apply the promo code to a particular order
  def apply(order)
    self.message = INVALID_MESSAGE
    
    if self.percent_discount && self.percent_discount > 0
      discount = (self.percent_discount / 100) * 
                  order.sub_total
    else
      discount = self.dollar_discount          
    end
    self.message = SUCCESS_MESSAGE
    
    if order
      order.promo_code = self.code.upcase
      order.free_shipping = true if self.free_shipping
      order.promo_discount = discount
      order.save!
    end
    
    self.message
  end
   
   
   # promo code application
   def self.apply(order, promo_code)
     begin
       promo_code = promo_code.upcase 
       promo = PromoCode.find_by_code(promo_code)
     rescue
       order.promo_code = ''
       order.free_shipping = false
       order.promo_discount = ''
       order.save!
     end 
     if promo
       promo.apply(order)
     else
       promo = PromoCode.new
       promo.message = INVALID_MESSAGE
     end
     
     promo
   end
   
end