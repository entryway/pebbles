class ShippingsController < ApplicationController
  
  def create
    session[:zipcode] ||= params[:zipcode] 
    zipcode = session[:zipcode]
    quantity = params[:quantity]
    product_id = params[:id]
    @shipping = ShippingCalculations.quote(product_id, quantity, zipcode)
    render :partial => 'products/shipping'
  end
  
end