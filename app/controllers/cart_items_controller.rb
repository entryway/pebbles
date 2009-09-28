class CartItemsController < ApplicationController


  def index
  end 


  def new
    @cart_item = CartItem.new
  end
  
  def create
    @cart = current_cart
    product_id = params[:id]
    quantity = params[:quantity]
    options = params[:options]
    CartItem.add_product(@cart, product_id, quantity, options)
    redirect_to cart_path(@cart)
    
  #rescue
  #  flash[:message] = "Product not found"
  #  redirect_to '/'
  end
  
  
  def destroy
    cart = current_cart
    cart_item = cart.cart_items.find(params[:id])
    if cart_item
      cart_item.destroy
    end
    redirect_to cart_path(cart)
  end
  
  
 
  
end
