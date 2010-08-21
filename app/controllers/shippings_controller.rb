class ShippingsController < ApplicationController

  def create
    session[:zipcode] = params[:zipcode] if !params[:zipcode].blank?
    zipcode = session[:zipcode]
    quantity = params[:quantity].to_i
    product_id = params[:id]
    # create an array of selected accessory ids; note that it helps to reject the collected nil
    accessories = ProductAccessory.selected_accessories(params[:accessories]) if params[:accessories]                        
    @shipping = ShippingCalculations.product_quote(product_id, quantity, zipcode, accessories)
    render :partial => 'products/shipping'
  end
    

end
