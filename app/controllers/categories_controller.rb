class CategoriesController < ApplicationController
  layout 'shopping'

  before_filter :ensure_current_post_show_url, :only => :show

  def index
    @categories = Category.position_sorted
    @products = Product.featured
  end

  def show
    @category = Category.find(params[:id])
    @categories = @category.children.active
    @products = @category.paged_products(params[:page], 9)
    respond_to do |format|
      format.html
      format.js do
        products = @category.descended_paged_products(params[:page], 9)
        render :partial =>  '/products/product_items',
               :locals => { :products => products }
      end
    end
  end

private

  def ensure_current_post_show_url    
    @category = Category.find(params[:id])
    unless @category.friendly_id_status.best?
      redirect_to @category, :status => :moved_permanently
    end
  end

end
