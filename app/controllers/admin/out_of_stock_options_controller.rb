module Admin

  class OutOfStockOptionsController < ApplicationController
    require_role "admin"
    
    # add a new out of stock option
    def create
      puts params.to_yaml
      product = Product.find(params[:product_id])
      out_of_stock_option = OutOfStockOption.new
      
      # adds out of stock selections
      selections = params[:selections]
      unless product.out_of_stock?(selections)
        selections.each do |selection|
          product_option_selection = ProductOptionSelection.find(selection)
          if product_option_selection
            out_of_stock_selection = OutOfStockOptionSelection.new(
                                                  :product_option_selection =>
                                                  product_option_selection
                                     )
            out_of_stock_option.out_of_stock_option_selections << out_of_stock_selection
          end
        end
      
        product.out_of_stock_options << out_of_stock_option
      end
      
      render :partial => 'admin/products/out_of_stock_options/out_of_stock_options',
             :locals => { :out_of_stock_options => product.out_of_stock_options }
    end
    
    
    # delete a out of stock option
    def destroy
      product = Product.find(params[:product_id])     
      out_of_stock_option = OutOfStockOption.find(params[:id])
      product.out_of_stock_options.delete(out_of_stock_option)
      
      render :partial => 'admin/products/out_of_stock_options/out_of_stock_options',
             :locals => { :out_of_stock_options => product.out_of_stock_options }
    end

  end

end