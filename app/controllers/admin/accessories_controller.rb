module Admin
  class AccessoriesController < ApplicationController
    layout "admin"
    require_role "admin"
    def edit
      @product = Product.find(params[:product_id])
      @product_accessories = @product.product_accessories
      @categories = Category.root.all_children
    end
    
    def show
      @product = Product.find(params[:product_id])
      @category = Category.find(params[:category_id])
      @products = @category.products
    end
    
    def create
      @product = Product.find(params[:product_id])
      accessory = Product.find(params[:accessory_id])
      @product.accessories << accessory
      @product_accessories = @product.product_accessories
      respond_to do |format|
        format.js { 
          render :partial => 'accessories'
        }
      end
      
    end
    
    def update
      @product = Product.find(params[:product_id])
      @product_accessory = ProductAccessory.find(params[:id])
      @product_accessory.update_attributes(params[:product_accessory])
      @product_accessories = @product.product_accessories
      respond_to do |format|
        format.js { 
          render :partial => 'accessories'
        }
      end
    end
    
    def destroy
      @product = Product.find(params[:product_id])
      @product_accessory = ProductAccessory.find(params[:id])
      @product_accessory.destroy
      @product_accessories = @product.product_accessories
       respond_to do |format|
          format.js { 
            render :partial => 'accessories'
          }
        end
    end
    
  end
end
