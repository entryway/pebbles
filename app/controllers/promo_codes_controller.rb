class PromoCodesController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  ssl_allowed :create
  
  def create
    cart = current_cart

    promo_code = params[:promo_code]
    promo = PromoCode.apply(cart, promo_code)

    promo_code_message = promo.message
    promo_code_note = promo.note
    product_total = cart.product_total
    tax_total = cart.tax_total
    method = ShippingMethod.find(active_shipping_method_id)
    shipping_total = cart.shipping_total(method)
    grand_total = cart.grand_total(shipping_total)
    
    render :json => { :promo_code_message => promo_code_message,
                      :promo_code_note => promo_code_note,
                      :no_tax => tax_total == 0,
                      :tax_total => number_to_currency(tax_total), 
                      :shipping_total => number_to_currency(shipping_total),
                      :grand_total => number_to_currency(grand_total) }
    
  end

end
