# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>resources</tt>, here you would add just <tt>resources</tt>

# resources :ecommerces

  resources :users
  resources :promo_codes
  resource :session, :controller => 'sessions'
  resources :stores
  connect '', :controller => 'index', :action => 'index'
  connect '', :controller => 'catalog', :action => 'products'

  resources :carts do |cart|
    cart.resources :cart_items
  end
  
  resources :orders
  resources :categories do |categories|
    categories.resources :products
  end
  
  resources :stores
  resources :shippings
  
  namespace :admin do |admin|
    admin.resources :authorizations

    admin.resources :categories
    admin.resources :coupons
    admin.resources :ebay_orders
    
    admin.resources :orders
    admin.resources :order_items

    admin.resources :promo_codes
    admin.resources :products, :has_many => [:product_options, 
                                             :out_of_stock_options, 
                                             :accessories]
                                             
    admin.resources :regions, :has_many => :shipping_methods
    
    admin.resources :stores

    admin.resources :vendors
    admin.resources :optimizations
    admin.resources :configurations
  
  end
              
  signup '/signup', :controller => 'users', :action => 'new'
  login  '/login', :controller => 'sessions', :action => 'new'
  logout '/logout', :controller => 'sessions', :action => 'destroy'
                 
 connect '', :controller => 'index', :action => 'index'
      
 connect 'admin/:action', :controller => 'admin'
