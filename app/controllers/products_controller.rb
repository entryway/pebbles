class ProductsController < ApplicationController
  include ShippingCalculations
  layout 'shopping'

  def index
    @category = Category.find(params[:category_id])
    @products = @category.paged_products(params[:page], 15)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @product.to_xml }
    end
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    @products = @category.paged_products(params[:page], 15)
    @cart_item = CartItem.new
    @cart = current_cart
    @inventory = @cart.inventory_remaining(@product)
    zipcode = session[:zipcode]
    @shipping = ShippingCalculations.product_quote(@product.id, 1 , zipcode) if zipcode
  
    respond_to do |format|
      format.html # show.rhtml
      format.js
      format.xml  { render :xml => @product.to_xml }
    end
  end
    
end

