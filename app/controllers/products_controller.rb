class ProductsController < ApplicationController
  include ShippingCalculations
  layout 'shopping'

  before_filter :ensure_current_post_show_url, :only => :show  
  before_filter :ensure_current_post_index_url, :only => :index  

  def index
    @category = Category.find(params[:category_id])
    @products = @category.paged_products(params[:page], 15)

    respond_to do |format|
      format.html # index.rhtml
      format.js do
        products = @category.paged_products(params[:page], 9)
        render :partial =>  '/products/product_items', 
               :locals => { :products => products }
        
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    @products = @category.paged_products(params[:page], 15)
    @cart_item = CartItem.new
    @cart = current_cart
    @inventory = Inventory.new.inventory_remaining(@cart, @product)
    zipcode = session[:zipcode]
    @shipping = ShippingCalculations.product_quote(@product.id, 1 , zipcode) if zipcode
  
    respond_to do |format|
      format.html # show.rhtml
      format.js
      format.xml  { render :xml => @product.to_xml }
    end
  end
  
private

  def ensure_current_post_show_url
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    redirect_to category_product_path(@category, @product), 
                :status => :moved_permanently if @product.has_better_id? || @category.has_better_id?
  end

  def ensure_current_post_index_url
    @category = Category.find(params[:category_id])
    redirect_to category_products_path(@category), 
                :status => :moved_permanently if @category.has_better_id?
  end

    
end

