module Admin

class AuthorizationsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    # set amount if exists, else use order total
    amount = params[:post_authorize_amount].to_d unless params[:post_authorize_amount].blank?
    amount ||= @order.total_in_cents

    if @order.authorized?
      @order.capture_payment({:amount => amount})
    else
      @order.authorize_payment
    end
    @order.save!

    render :partial => 'admin/orders/order_transactions'
  end


end


end
