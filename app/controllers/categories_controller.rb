class CategoriesController < ApplicationController
  layout 'shopping'

  # GET /categories
  def index
    @categories = Category.root
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])
    if @category.products.size > 0
      redirect_to category_products_path(@category)
    else
      @categories = @category.alpha_sorted
    end
  end

end
