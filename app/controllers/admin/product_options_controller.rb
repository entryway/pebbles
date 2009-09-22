

module Admin

  class ProductOptionsController < ApplicationController
    require_role "admin"
  
    # TODO: move option selection methods to nested ProductOptionSelectionController
    
    # add a new product selection to the product option
    def add_option_selection      
      @product = Product.find(params[:product_id])
      @product_option = ProductOption.find(params[:product_option_id])
      name = params[:product_option_selection][:name]
      weight_adjustment = params[:product_option_selection][:weight_adjustment]
      price_adjustment = params[:product_option_selection][:price_adjustment]
      sku_adjustment = params[:product_option_selection][:sku_adjustment]
      @selection = ProductOptionSelection.new(:name => name,
                                              :weight_adjustment => weight_adjustment,
                                              :price_adjustment => price_adjustment,
                                              :sku_adjustment => sku_adjustment)
      @product_option.product_option_selections << @selection

    end
    
    # add an image to the product option selection
    def add_option_selection_image
      image = ProductOptionSelectionImage.new(params[:option_selection_image])
      option_selection = ProductOptionSelection.find(params[:id])
      option_selection.images << image
      responds_to_parent do
        render :update do |page| 
          page[:image_list].replace_html :partial => '/admin/product_options/option_selection_image_list', 
                                         :locals => { :option_selection => option_selection }
        end
      end
    end
    
    # remove an image from the product option selection
    def remove_option_selection_image
      option_selection = ProductOptionSelection.find(params[:id])
      image = ProductOptionSelectionImage.find(params[:image_id])
      option_selection.images.delete(image)  

      respond_to do |format|
        format.js { 
          render :partial => '/admin/product_options/option_selection_image_list', 
                 :locals => { :option_selection => option_selection }
        }
      end  
    end
    
    # edit the option selection
    def edit_option_selection
      @product = Product.find(params[:product_id])
      @product_option = ProductOption.find(params[:product_option_id])
      @option_selection = ProductOptionSelection.find(params[:id])
      unless params[:product_option_selection].nil?
        @option_selection.name = params[:product_option_selection][:name]
        @option_selection.weight_adjustment = params[:product_option_selection][:weight_adjustment]
        @option_selection.price_adjustment = params[:product_option_selection][:price_adjustment]
        @option_selection.sku_adjustment = params[:product_option_selection][:sku_adjustment]
        @option_selection.save!
        image = ProductOptionSelectionImage.new(params[:product_option_selection][:image])
        @option_selection.images  << image
      end
    end
    
    # remove product selection to the product option
    def remove_option_selection      
      @product = Product.find(params[:product_id])
      @product_option = ProductOption.find(params[:product_option_id])
      @selection = ProductOptionSelection.find(params[:selection_id])
      
      @product_option.product_option_selections.delete(@selection)
    end
    
    # add the existing product option to the product
    def apply_option_to_product
      @product = Product.find(params[:product_id])
  
      @product_option = ProductOption.find(params[:product_option][:id])
      @product_option.update_attributes(params[:product_option])

      product_option_instance = ProductOptionInstance.new(:product => @product, 
                                                          :product_option => @product_option)
                                                          
      product_option_instance.save

      @available_options = ProductOption.find(:all, :order => 'name')
    end
    
    # add a new product option
    def create
      @product = Product.find(params[:product_id])
  
      @product_option = ProductOption.new(params[:product_option])
      product_option_instance = ProductOptionInstance.new(:product => @product, 
                                                          :product_option => @product_option)
      @product_option_selection = ProductOptionSelection.new
      @available_options = ProductOption.find(:all, :order => 'name')
    
      if product_option_instance.save
        flash[:notice] = 'New Product Option Saved'
      else 
        flash[:notice] = 'Product Option Not Saved'
      end
    end
    
    # edit a current product option
    def edit
      @product = Product.find(params[:id])
      product_option_id = params[:product_option_id]
      unless product_option_id
        # product option in select drop-down
        product_option_id = params[:product_option][:id]
      end
      @product_option = ProductOption.find(product_option_id)
    end
    
    
    # update a current product option
    def update
      @product_option = ProductOption.find(params[:product_option][:id])
      @product = Product.find(params[:product_id])
      @product_option.update_attributes(params[:product_option])
      
      @available_options = ProductOption.find(:all, :order => 'name')
    end
    
    
    # delete a product option
    def destroy
      @product = Product.find(params[:product_id])     
      @product_option = ProductOption.find(params[:id])
      @product.product_options.delete(@product_option)
      
      @available_options = ProductOption.find(:all, :order => 'name') 
    end

  end

end