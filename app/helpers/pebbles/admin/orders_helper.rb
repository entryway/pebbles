module Pebbles::Admin
  
  module OrdersHelper
    
    def preauthorized(order)
      true if order.authorized?
    end
    

    ##
    # Displays an out of stock message if the product does not exist (deleted
    # from the system) or is out of stock.
    #
    # @param [Product] product The product to determine if out of stock or not.
    # @return [String] An out of stock message if product is so.
    def out_of_stock_message(product)
      "out of stock" unless product 
    end
  end
  
  
end
