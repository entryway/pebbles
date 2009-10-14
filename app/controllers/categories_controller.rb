class CategoriesController < ApplicationController
  layout 'shopping'

  # GET /categories
  def index
    @categories = Category.position_sorted
    @products = Product.featured
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])
    @categories = @category.children.active
    @products = @category.paged_products(params[:page], 15)
  end

end
