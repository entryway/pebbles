class ShippingMethodsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  ssl_allowed :index, :update

  def index
    region = Region.find(params[:region_id])
    @shipping_methods = region.shipping_methods
    @default_method = region.default_shipping_method

    cart = current_cart
    @subtotal = cart.sub_total
    @shipping_total = cart.shipping_total(@default_method)
    @grand_total = cart.grand_total(@shipping_total)
    @order = true if params[:order]

    # change the active region
    self.active_shipping_region_id = region.id
    self.active_shipping_method_id = @default_method.id
    render :layout => false
  end

  def update
    method = ShippingMethod.find(params[:id])

    cart = current_cart
    shipping_total = cart.shipping_total(method)
    grand_total = cart.grand_total(shipping_total)

    # change active shipping rate depending on selection
    self.active_shipping_method_id = method.id

    render :json => { :shipping_total => number_to_currency(shipping_total),
                      :grand_total => number_to_currency(grand_total) }

  end


end
