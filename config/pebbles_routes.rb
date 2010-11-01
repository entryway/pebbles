ActionController::Routing::Routes.draw do |map|
   map.resources :contacts, :only => :create
   map.resources :users
   map.resources :promo_codes

   map.resource :session, :controller => 'sessions'

   map.resources :carts do |cart|
     cart.resources :cart_items
   end

   map.resources :orders
   map.resources :categories do |categories|
     categories.resources :products
   end
   map.resources :shippings
   map.resources :variants
   map.resources :variant_images, :only => [:show, :index]
   map.resources :regions, :has_many => [:shipping_methods]
   map.resources :taxes, :only => :update

   map.namespace :admin do |admin|
     admin.resources :authorizations

     admin.resources :categories, :has_many => [:category_images, :category_icons],
                                  :member => { :reorder => :put }
     admin.resources :category_icons, :has_many => :category_icon_hovers

     admin.resources :ebay_orders

     admin.resources :orders, :member => { :change_delivery_status => :put }
     admin.resources :order_items

     admin.resource  :product_export, :controller => 'product_export'
     admin.resources :promo_codes
     admin.resources :products, :has_many => [:product_options, :out_of_stock_options, :variants,
                                              :product_images]
     admin.resources :product_images, :has_many => [:product_image_thumbnails, :product_large_images]
     admin.resources :regions, :has_many => :shipping_methods

     admin.resources :stores

     admin.resources :vendors
     admin.resources :variant_images, :has_many => [:variant_image_thumbnails, :variant_large_images]
     admin.resources :variants, :only => :update
   end

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.root :controller => 'index', :action => 'index'

  map.connect 'admin/:action', :controller => 'admin'
end
