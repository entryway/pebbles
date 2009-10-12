class CartsController < ApplicationController
  layout 'shopping'

  # refresh the shipping methods depending on region selected
  def refresh_shipping_methods
    region = Region.find(params['region'])
    @shipping_methods = region.shipping_methods
    @default_method = region.default_shipping_method

    @cart = current_cart
    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_total(region, @default_method)
    @grand_total = @cart.grand_total(@shipping_total)

    # change the active region
    set_active_shipping_region_id(region.id)
    set_active_shipping_method_id(@default_method.id)
  end

  # refresh order totals depending on new shipping method
  def refresh_totals
    region = Region.find(active_shipping_region_id)
    method = ShippingMethod.find(params['method'])

    @cart = current_cart
    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_total(region, method)
    @grand_total = @cart.grand_total(@shipping_total)

    # change active shipping rate depending on selection
    set_active_shipping_method_id(method.id)
  end

  def show
    @cart = current_cart
    @cart.validate 
    region = Region.find(active_shipping_region_id)
    method = active_shipping_method_id
    @shipping_methods = region.shipping_methods
    @default_method = ShippingMethod.find(method)

    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_total(@default_method)
    @grand_total = @cart.grand_total(@shipping_total)
  end

  def update
    @cart = current_cart
    if @cart.update_attributes(params[:cart])
      flash[:notice] = "Your cart was updated."
      redirect_to cart
    else
      region = Region.find(active_shipping_region_id)
      method = active_shipping_method_id
      @shipping_methods = region.shipping_methods
      @default_method = ShippingMethod.find(method)
      @subtotal = @cart.sub_total
      @shipping_total = @cart.shipping_total(@default_method)
      @grand_total = @cart.grand_total(@shipping_total)
      render :action => 'show'
    end
  end

end
