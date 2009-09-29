class CategoriesController < ApplicationController
  layout 'shopping'

  # GET /categories
  def index
    @categories = Category.position_sorted
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])
    if @category.leaf?
      redirect_to category_products_path(@category)
    else
      @categories = @category.children.active
      @products = @category.products
    end
  end

end
