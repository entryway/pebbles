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
    options = params[:options].map{|id| id.to_i} if params[:options]
    # ensure the product is available
    product = Product.find(product_id)
    if product.available
      @cart.add_product(product_id, quantity, options)
    end
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
