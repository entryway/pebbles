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
    region = Region.find(active_shipping_region_id)
    method = active_shipping_method_id
    @shipping_methods = region.shipping_methods
    @default_method = ShippingMethod.find(method)

    @cart = current_cart
    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_total(@default_method)
    @grand_total = @cart.grand_total(@shipping_total)
  end

  def update
    cart = current_cart
    cart.cart_items.each do |cart_item|
      quantity = CartItem.valid_quantity(params['qty' + cart_item.id.to_s])
      if cart_item.quantity != quantity || quantity == 1
        cart_item.quantity = quantity
        cart_item.save
      end
    end
    flash[:notice] = "Your cart was updated."

    redirect_to current_cart
  end

end
