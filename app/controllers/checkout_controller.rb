class CheckoutController < ApplicationController
  ssl_required :index, :review, :index, :process_addresses, :place_order
  ssl_allowed :confirmation
    
  def index
    if current_cart.cart_items.length == 0
      flash[:notice] = "Please add items to your cart before checking out."
    end
    @order = Order.new
    # TODO: default status to "open" so this line isn't duplicated in index and place_order
    @order.status = "open"
  end
  
  def confirmation
    # send confirmation email, write order number
  end
  
  def initialize_order
    @order.customer_ip = request.remote_ip
    @order.status = "open"
    @order.add_order_items_from_cart(current_cart)
    
    @billing_address = session[:billing_address]
    @order.order_addresses << @billing_address
    
    @shipping_address = session[:shipping_address]
    @order.order_addresses << @shipping_address
  end
  
  def review
    @order = Order.new()

    initialize_order
    @order.calculate_order_costs    
  end
  
  def place_order      
    @order = Order.new(params[:order])
    initialize_order
    @order.calculate_order_costs    
    
    if @order.save
            
      if @order.process 
        # Empty the cart 
        # @cart.items.  ??
        
        # expire_fragment(:controller => "cart", 
        #                 :action => "show", 
        #                 :id => cart)
        current_cart.cart_items.delete_all
      
        redirect_to :action => 'confirmation' 
      else 
        flash[:notice] = "Error while placing order. '#{@order.error_message}. <br/>" +
           "Please review billing address, billing name, and ALL credit card fields. <br/>" +
           "If you continue to have an issue please call us at 540.789.2700."
        render :action => 'review' 
      end 
    else 
      render :action => 'review' 
    end
    
  end
  
  def process_addresses
    # build billing address
    @different_shipping = params[:different_shipping]
    @billing_address = OrderAddress.new(params[:billing_address])
    
    # build shipping address
    if @different_shipping
      @shipping_address = OrderAddress.new(params[:shipping_address])
    else
      # create from billing
      @shipping_address = OrderAddress.new(params[:billing_address])   
    end

    # validate order user and billing address
    valid_billing = @billing_address.valid?
    valid_shipping = @shipping_address.valid? 

    if valid_billing && valid_shipping
      # default billing address to be the shipping address as well
      @shipping_address.is_shipping = true
      @billing_address.is_shipping = false
      
     
      session[:shipping_address] = @shipping_address
      session[:billing_address] = @billing_address

      redirect_to :action => 'review'
    else
      render :action => 'index'      
    end
    
  end

end
