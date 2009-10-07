class TaxesController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  ssl_allowed :update  

  def update
    cart = current_cart
    cart.billing_state = params[:billing_state]
    cart.save!
    method = ShippingMethod.find(active_shipping_method_id)
    shipping_total = cart.shipping_total(method)
    
    tax_total = cart.tax_total
    grand_total = cart.grand_total(shipping_total)
    
    render :json => { :no_tax => tax_total == 0,
                      :tax_total => number_to_currency(tax_total), 
                      :grand_total => number_to_currency(grand_total) }
    
  end 
    

end