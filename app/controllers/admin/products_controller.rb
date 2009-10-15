
module Admin

class ProductsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  # add a product to the category
  def add_to_category
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_select])
    @product.categories << @category
  end
  
  # remove product from category
  def remove_from_category
    product = Product.find(params[:id])
    category = Category.find(params[:category_id])
    product.categories.delete(category)

    respond_to do |format|
      format.js { 
        render :partial => 'category_list', 
        :locals => { :product_id => product.id, :categories => product.categories }
      }
    end
  end
  
  # upload an image fu
  def upload_image
      @image = ProductImage.new(params[:mugshot])
      if @image.save
        flash[:notice] = 'Mugshot was successfully created.'     
      else
        render :action => :new
      end
  end
  
  # The REST:
  
  def index
    @products = Product.paginate(:page => params[:page], :order => 'name')
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @products.to_xml }
    end
  end


  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @product.to_xml }
    end
  end


  def new
    @product = Product.new
    3.times { @product.quantity_discounts.build }
    
    @vendors = Vendor.find(:all)
    @categories = Category.find(:all)
  end


  def edit
    @product = Product.find(params[:id])
    @vendors = Vendor.find(:all)
    @categories = Category.root.descendants
    @available_options = ProductOption.find(:all, :order => 'name')
    @product_option = ProductOption.new
    @product_image = ProductImage.new
    @variant_image = VariantImage.new
  end


  def create
    @product = Product.new(params[:product])
    @vendors = Vendor.find(:all)
    @categories = Category.find(:all)

    if @product.save
      flash[:notice] = 'You have just created a new product, continue adding information below or move on..'
      redirect_to edit_admin_product_path(@product.id)
    else
      render :action => 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product #{@product.name} was successfully updated."
      redirect_to edit_admin_product_path(@product.id) 
    else
      @vendors = Vendor.find(:all)
      @categories = Category.root.descendants
      @available_options = ProductOption.find(:all, :order => 'name')
      @product_option = ProductOption.new
      render :action => "edit"
    end
  end


  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_url 
  end
end

end

