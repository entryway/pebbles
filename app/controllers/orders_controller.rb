
class OrdersController < ApplicationController
  include ActiveMerchant::Billing
  include ActiveMerchant::Billing::Integrations

  layout 'shopping'

  ssl_required :new, :create
         
  def new
    @order = Order.new
    @order.credit_card = CreditCard.new
    @order.billing_address = Address.new
    @order.shipping_address = Address.new
    @cart = current_cart
    @cart.validate
    
    refresh_cart
  end
  
  def create
    @cart = current_cart
    # move to factory, little funky with validation, maybe builder?
    options = params.merge(:active_shipping_method_id => active_shipping_method_id,
                           :active_shipping_region_id => active_shipping_region_id)
    @order = OrderFactory.create_web_order(@cart, options)
    if @order.invalid
      puts "errors in controller #{@cart.errors.on_base}"
      refresh_cart      
      render :action => 'new' and return
    else
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
            @cart.destroy
          rescue
            # cart wasn't destroyed, so what
          end
          set_current_cart(nil)
        end
      rescue Exception => exception
        @processing_error_message = error_message(exception)
        refresh_cart
        ExceptionNotifier.deliver_exception_notification(exception, self, request, params)
        render :action => 'new' and return      
      end
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
   
    @cart ||= current_cart
    @product_total = @cart.product_total
    PromoCode.apply(@cart, @cart.promo_code) if @cart.promo_code
    @discount = @cart.promo_discount
    @shipping_total = @cart.shipping_total(@default_method)
    @grand_total = @cart.grand_total(@shipping_total)
  end
  

end

