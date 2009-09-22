module Pebbles::Admin
  
  module OrdersHelper
    
    def preauthorized(order)
      true if order.authorized?
    end
    
  end
  
  
end
