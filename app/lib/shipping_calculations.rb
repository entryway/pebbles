module ShippingCalculations
  
  include ActiveMerchant::Shipping
  
  # calculate cost for product item
  def self.product_quote(product_id, quantity, zipcode, accessories = [])
    product = Product.find(product_id)
    quote = case product.determined_shipping_type 
    when ShippingType::FREE_SHIPPING
      0
    when ShippingType::FLAT_RATE_SHIPPING
      self.flat_rate_shipping_quote(product, accessories, zipcode, quantity)
    when ShippingType::REAL_TIME_SHIPPING
      self.real_time_shipping_quote(product, accessories, zipcode, quantity)
    end 
    quote
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
  
  private
  def self.flat_rate_shipping_quote(product, accessories, zipcode, quantity)
    quote = product.flat_rate_shipping * quantity
    weights = Array.new
    quote += self.accessory_quote(weights, accessories, zipcode, product.vendor.zipcode)
  end
  
  def self.real_time_shipping_quote(product, accessories, zipcode, quantity)
    weights = quantity_weights(product, quantity)
    quote = self.accessory_quote(weights, accessories, zipcode, product.vendor.zipcode)
  end
  
  def self.accessory_quote(weights, accessories, zipcode, vendor_zipcode)
    quote = 0
    accessories.each do |accessory|
      case accessory.determined_shipping_type
      when ShippingType::FREE_SHIPPING
        quote += 0
      when ShippingType::FLAT_RATE_SHIPPING
        quote += accessory.flat_rate_shipping
      when ShippingType::REAL_TIME_SHIPPING 
        # for now we are assuming that only one accessory is added otherwise this will need to 
        # do something like quantity.times do...
        weights << accessory.weight
      end
    end
    quote += self.shipping_quote(weights, zipcode, vendor_zipcode) unless weights.empty?
    quote
  end
  
  def self.shipping_quote(weights, zipcode, vendor_zipcode)
    packages = build_packages(weights)
    quote = quote_packages(packages, zipcode, vendor_zipcode)
  end
  
  def self.build_packages(weights)
    packages = Array.new
    weights.each do |weight|
      package = Package.new(weight * 16, nil, :units => :imperial)
      packages << package
    end
    packages
  end
    
  def self.quote_packages(packages, zipcode, vendor_zipcode)
    origin = Location.new(:country => 'US', :zip => vendor_zipcode)
    country = /^\d{5}([\-]\d{4})?$/.match(zipcode)? 'US' : 'CA'
    destination = Location.new(:country => country, :postal_code => zipcode)
    ups = UPS.new(:login => APP_CONFIG['ups_login'], :password => APP_CONFIG['ups_password'], 
                  :key => APP_CONFIG['ups_key'])
    response = ups.find_rates(origin, destination, packages)
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
  
  def calculate_shipping_per_vendor(items, zipcode, vendor_zipcode)
    # we create a separate package for each quantity of each item 
    weights = Array.new
    shipping_total = 0
    items.each do |item|
      product = item.product
      case product.determined_shipping_type
      when ShippingType::FREE_SHIPPING
        shipping_total += 0
      when ShippingType::FLAT_RATE_SHIPPING
        shipping_total += product.flat_rate_shipping
      when ShippingType::REAL_TIME_SHIPPING 
        weights += ShippingCalculations.quantity_weights(product, item.quantity)
      end
    end
    unless weights.empty?  
      shipping_total += ShippingCalculations.shipping_quote(weights, zipcode, vendor_zipcode)
    end
    shipping_total
  end
  
  def total_weight(items)
    sum = items.sum {|item| item.quantity * item.product.weight}
  end
  
end