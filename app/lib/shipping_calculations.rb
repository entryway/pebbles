require 'shipping'
require 'active_shipping'

module ShippingCalculations
  
  include ActiveMerchant::Shipping
  
  # calculate cost for product item
  def self.product_quote(product_id, quantity, zipcode, accessory_ids = nil)
    product = Product.find(product_id)
    if product.free_shipping
      quote = 0
    else 
      accessories = []
      accessories = Product.find(accessory_ids) if accessory_ids
      vendor_zipcode = product.vendor.zipcode
      weights = quantity_weights(product, quantity)
      accessories.each do |accessory|
        weights << accessory.weight 
      end
      quote = self.shipping_quote(weights, zipcode, vendor_zipcode)
    end
    quote
  end
  
  def self.shipping_quote(weights, zipcode, vendor_zipcode)
    packages = Array.new
    weights.each do |weight|
      package = Package.new(weight * 16, nil, :units => :imperial)
      packages << package
    end
    
    origin = Location.new(:country => 'US', :zip => vendor_zipcode)
    country = /^\d{5}([\-]\d{4})?$/.match(zipcode)? 'US' : 'CA'
    destination = Location.new(:country => country, :postal_code => zipcode)
    ups = UPS.new(:login => APP_CONFIG['ups_login'], :password => APP_CONFIG['ups_password'], 
                  :key => APP_CONFIG['ups_key'])
    response = ups.find_rates(origin, destination, packages)
    puts response.rates.inspect
    quote = response.rates.sort_by(&:price).first.price * 0.01
  end
  
  def self.quantity_weights(product, quantity)
    weights = Array.new
    quantity.times do 
      weight = product.weight
      weights << weight
    end
    weights
  end
  
  # calculates total shipping cost
  def calculate_real_time_shipping(items, zipcode)
    grouped_items = items.group_by { |item| item.product.vendor }
    shipping_total = 0
    grouped_items.keys.each do |vendor|
      ## this might be useful if a vendor packages products together:
      # if vendor.groups_packages
      #     weight = total_weight(grouped_items[vendor])
      #     shipping_total += shipping_quote([weight], zipcode, vendor.zipcode)
      items = grouped_items[vendor]
      vendor_total = calculate_shipping_per_vendor(items, zipcode, vendor.zipcode)
      shipping_total += vendor_total
    end
    shipping_total
  end
  
  def calculate_shipping_per_vendor(items, zipcode, vendor_zipcode)
    # we create a separate package for each quantity of each item 
    weights = Array.new
    items.each do |item|
      product = item.product
      unless product.free_shipping
        weights += ShippingCalculations.quantity_weights(product, item.quantity)
      end
    end
    shipping_total = ShippingCalculations.shipping_quote(weights, zipcode, vendor_zipcode)
  end
  
  def total_weight(items)
    sum = items.sum {|item| item.quantity * item.product.weight}
  end
  
end