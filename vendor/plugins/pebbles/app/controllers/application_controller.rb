class ApplicationController < ActionController::Base 
  include AuthenticatedSystem
  include RoleRequirementSystem
  include SslRequirement
  include Wholesaler
  
  before_filter :verify_wholesaler
  filter_parameter_logging :credit_card
  
  # the current shipping region
  helper_method :active_shipping_region_id
  def active_shipping_region_id
    if session[:shipping_region_id].nil?
      # set default shipping region
      session[:shipping_region_id] = Region.find(:first).id
    end
    session[:shipping_region_id]
  end
  # grab active region
  def set_active_shipping_region_id(region_value)
    session[:shipping_region_id] = region_value
  end
  
  # the current shipping method
  helper_method :active_shipping_method_id
  def active_shipping_method_id
    if session[:shipping_method_id].nil?
      # set default shipping rate
      region_id = active_shipping_region_id
      region = Region.find(region_id)
      method = region.default_shipping_method
      session[:shipping_method_id] = method.id unless method.nil?
    end
    session[:shipping_method_id]
  end
  # HACK: couldn't get active_shipping_method_id=() to work?
  def set_active_shipping_method_id(method_value)
    session[:shipping_method_id] = method_value
  end
  
  # obtain the current cart
  helper_method :current_cart
  def current_cart 
    cart = nil
    # not logged in, so we are a visitor
    if session[:visitor_cart_id].nil? 
      # create new visitor basket and store id for obtaining
      visitor_cart = Cart.create(:name => "Visitor Cart")
      session[:visitor_cart_id] = visitor_cart.id
      cart =  visitor_cart
    else
      begin
        cart = Cart.find(session[:visitor_cart_id]) 
      rescue  
        # create new visitor basket and store id for obtaining
        visitor_cart = Cart.create(:name => "Visitor Cart")
        session[:visitor_cart_id] = visitor_cart.id
        cart =  visitor_cart
      end
    end   
    cart
  end
  # set current cart
  def set_current_cart(id)
    session[:visitor_cart_id] = id
  end

  # all the categories for browsing
  # TODO: CACHE
  helper_method :categories
  def categories 
    Category.position_sorted
  end
  
  # allows collapsing empty methods
  # empty_action :index, :empty
  def self.empty_action(*actions)
    actions.each {|action| class_eval("def #{action}; end")}
  end
end
