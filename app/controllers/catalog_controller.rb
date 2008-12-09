class CatalogController < ApplicationController
  
  # default store page
  def index
    @category = Category.find_by_name(params[:category])
    @products = Product.find(:all)
   # @cart = find_cart
  end
  
  # Displays all the products.
  def products
    if params[:category] then
      @category = Category.find_by_name(params[:category])
      @products = @category.products.find_by_active('1')
      @category_name = params[:category]
    else 
      @products = Product.find(:all)
      @category_name = "products"
    end
    @categories = Category.find(:all)
  end
  
  # Displays product details.
  def product_details
    @categories = Category.find(:all)
    @product = Product.find(params[:id])
  end
  
  
  # Displays products by category.
  def category
    @products = Product.find(:first)
    @categories = Category.find(params[:id])    
  end
  
  
  private 
  
   # redirect to index page.
  def redirect_to_index(msg=nil) 
    flash[:notice] = msg 
    redirect_to :action => :index 
  end
  
  
end
