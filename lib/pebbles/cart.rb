module Pebbles
  module Cart
    # obtain the current cart

    def current_cart
      cart = nil
      # not logged in, so we are a visitor
      if session[:visitor_cart_id].nil?
        # create new visitor basket and store id for obtaining
        visitor_cart = ::Cart.create(:name => "Visitor Cart")
        session[:visitor_cart_id] = visitor_cart.id
        cart =  visitor_cart
      else
        begin
          cart = ::Cart.find(session[:visitor_cart_id])
        rescue
          # create new visitor basket and store id for obtaining
          visitor_cart = ::Cart.create(:name => "Visitor Cart")
          session[:visitor_cart_id] = visitor_cart.id
          cart =  visitor_cart
        end
      end
      cart
    end
    # set current cart
    def set_current_cart(id)
      session[:visitor_cart_id] = id
    end
  end
end
