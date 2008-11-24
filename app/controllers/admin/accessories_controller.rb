module Admin
  class AccessoriesController < ApplicationController
    layout "admin"
    require_role "admin"
    def edit
      @product = Product.find(params[:product_id])
      @accessories = @product.accessories
      @categories = Category.root.all_children
    end
    
    def show
      @category = Category.find(params[:category_id])
      @products = @category.products
    end
  end
end
