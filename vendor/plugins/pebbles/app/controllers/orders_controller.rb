
class OrdersController < ApplicationController
  include ActiveMerchant::Billing
  include ActiveMerchant::Billing::Integrations

 # ssl_required :new, :create
       
  def new
    @order = Order.new
    @credit_card = CreditCard.new
    @billing_address = Address.new
    @shipping_address = Address.new
    
    refresh_cart
  end
  
  def create
    @cart = current_cart
    # move to factory, little funky with validation, maybe builder?
    @order = Order.new(params[:order])
    @order.order_type = OrderType::WEB
    @order.payment_type = 'credit_card'
    @order.delivery_status = 1
  
    @billing_address = Address.new(params[:billing_address])
    
    # piece-meal validation so user sees validation in steps
    
    # shipping address?
    shipping_same = true unless params[:address_choice].nil?
    unless shipping_same
      @shipping_address = Address.new(params[:shipping_address])
    else
      @shipping_address = @billing_address.clone
    end
 
    # CC validation 
    @credit_card = CreditCard.new(params[:credit_card])
    @credit_card.require_verification_value = true
    valid = @credit_card.valid? && @order.valid? &&
            @billing_address.valid? && @shipping_address.valid?
    unless valid
      refresh_cart
      render :action => 'new' and return
    end
    @order.shipping_address = @shipping_address 
    @order.billing_address = @billing_address
    @order.credit_card = @credit_card
    @order.credit_card_display = @order.credit_card.display_number
    
    promo = PromoCode.find_by_code(params[:order][:promo_code])
    promo.apply(@order) if promo
     
    @order.shipping_method_id = active_shipping_method_id
    @order.region_id = active_shipping_region_id
    @order.add_order_items_from_cart(@cart)
    
    begin
      Order.transaction do
        begin
          @order.process
        rescue Exceptions::FulfillmentException => exception
          # shipping exceptions allow the customer to move onto 
          # the congradulation screen, log and sent email
          ExceptionNotifier.deliver_exception_notification(exception, self, request, params) 
        rescue Exceptions::OrderException => exception
          @processing_error_message = error_message(exception)
          refresh_cart
          ExceptionNotifier.deliver_exception_notification(exception, self, request, params) 
          render :action => 'new' and return
        end
        # drop current cart
        begin
          #@cart.destroy
        rescue
          # cart wasn't destroyed, so what
        end
        #set_current_cart(nil)
      end
   rescue Exception => exception
     @processing_error_message = error_message(exception)
     refresh_cart
     ExceptionNotifier.deliver_exception_notification(exception, self, request, params)
     render :action => 'new' and return      
   end
  end
  

  private
  
  def error_message(exception)
    message = "There was an error processing your credit card:"
    exception = exception.to_s.strip.upcase
    if exception =~ /DUPLICATE/
      message = " This credit card was recently used to attempt an authorization, please wait 30 minutes and retry."
    elsif exception =~ /INSUFFICIENT FUNDS/
       message = " There were not enough funds on your credit card to process this order, please try with another credit card."
    elsif exception =~ /DECLINED/
       message = " Your credit card was DECLINED, please review your billing, credit card, and security code information and try again. "
    else
      message = " Sorry, there was an issue processing your order: <br/>
          #{exception.to_s.strip.upcase} <br/>
          Please let us know by emailing #{APP_CONFIG['support_email']} or calling #{APP_CONFIG['support_phone']}. "
    end
    message
  end
  
  private
  
  def refresh_cart
    region = Region.find(active_shipping_region_id)
    @shipping_methods = region.shipping_methods
    @default_method = ShippingMethod.find(active_shipping_method_id)

    @cart = current_cart
    @subtotal = @cart.sub_total
    @shipping_total = @cart.shipping_totals(region, @default_method, session[:zipcode])
    @grand_total = @cart.grand_total(@shipping_total)
  end
  

end

