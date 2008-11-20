module Admin

class AuthorizationsController < ApplicationController
  
  def update
    @order = Order.find(params[:id])
    # set amount if exists, else use order total 
    amount = params[:post_authorize_amount].to_d unless params[:post_authorize_amount].blank?
    amount ||= @order.total
    
    if @order.authorized?
      @order.capture_payment(amount)
    else
      @order.authorize_payment
    end
    @order.save!
  end
  
  
end


end