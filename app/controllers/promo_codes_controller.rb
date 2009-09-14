
class PromoCodesController < ApplicationController
  
  ssl_allowed :create
  
  def create
    cart = current_cart

    promo_code = params[:order][:promo_code]
    promo = PromoCode.apply(cart, promo_code)

    @promo_code_message = promo.message
    @promo_code_note = promo.free_shipping_note

    refresh_cart
  end
  
  private
  
  # TODO: move to common method, simplify cart logic
  def refresh_cart
    region = Region.find(active_shipping_region_id)
    @shipping_methods = region.shipping_methods
    @default_method = ShippingMethod.find(active_shipping_method_id)

    @cart = current_cart
    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_totals(region, @default_method)
    @grand_total = @cart.grand_total(@shipping_total)
  end
  
end
