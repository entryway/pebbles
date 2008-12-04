class ShippingsController < ApplicationController
  
  def create
    session[:zipcode] = params[:zipcode] if !params[:zipcode].blank?
    zipcode = session[:zipcode] 
    quantity = params[:quantity].to_i
    product_id = params[:id]
    # create an array of selected accessory ids; note that it helps to reject the collected nils
    if params[:accessory]
      accessory_ids = params[:accessory].collect {|k, v| k.to_i if v == '1' }.reject {|i| i == nil}                            
    end
    @shipping = ShippingCalculations.product_quote(product_id, quantity, zipcode, accessory_ids)
    render :partial => 'products/shipping'
  end
  
end