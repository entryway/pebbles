class ProductsController < ApplicationController
  include ShippingCalculations
  layout 'shopping'
  
  
  # GET /products
  # GET /products.xml
  def index
    @category = Category.find(params[:category_id])
    @products = @category.paged_products(params[:page], 15)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @product.to_xml }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    @products = @category.products.top_nine
    zipcode = session[:zipcode]
    @shipping = ShippingCalculations.product_quote(@product.id, 1 , zipcode) if zipcode
  
    respond_to do |format|
      format.html # show.rhtml
      format.js
      format.xml  { render :xml => @product.to_xml }
    end
  end
  
  def check_out_of_stock
    # send the param options selections array and id to see if that product_id 
    # is out_of_stock
    out_of_stock = OutOfStockOption.out_of_stock?(params[:id], params[:options])
    render :partial => 'add_to_cart', :locals => { :out_of_stock => out_of_stock }
  end

end

