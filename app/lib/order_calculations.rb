module OrderCalculations
  include ShippingCalculations
   
  def calculate_shipping_cost
    if Configuration.first.shipping_type == ShippingType::FLAT_RATE_SHIPPING
      @price = calculate_flat_rate_shipping
    elsif Configuration.first.shipping_type == ShippingType::REAL_TIME_SHIPPING
      @price = calculate_real_time_shipping(order_items, shipping_address.postal_code)
    end
  end
    
  def sub_total
    self.order_items.inject(0) {|sum, n| n.price * n.quantity + sum}    
  end
  
  def total
    self.product_cost + self.shipping_cost + 
      self.drop_shipping_cost + self.tax - self.promo_discount
  end
  
  def total_in_cents
    self.total * 100
  end
  
  def shipping_handling
    self.shipping_cost + self.drop_shipping_cost
  end
  
  def calculate_order_costs
    self.shipment_weight_total = 1.0 # default to one right now
    self.product_cost = sub_total
    self.drop_shipping_cost = 0
    self.tax = calculate_tax
    self.shipping_cost = calculate_shipping_cost

    # drop_ship_vendors = Array.new
    #     self.order_items.each do |item|
    #       self.product_cost += item.quantity * item.adjusted_price
    # 
    #       if item.drop_ship
    #         unless drop_ship_vendors.include?(item.supplier_id)
    #           # vendor does not exist in the array, so
    #           # add the drop ship amount for this vendor
    #           # to the order's total drop ship amount
    #           self.drop_shipping_cost += item.drop_shipping_cost
    # 
    #           # add vendor to the array, so drop ship amount isn't re-added 
    #           # if the customer has another item in his cart from this vendor
    #           drop_ship_vendors.push(item.supplier_id)          
    #         end
    #       else
    #         #TODO: if free shipping
    #         #self.shipment_weight_total += item.quantity * item.adjusted_weight
    #       end
    #     end
    #     #calculate_quantity_discounts 
    #     #calculate_tax
    total
  end
  
  
  def calculate_quantity_discounts
    # quantity discounts 
    discount = 0
    self.order_items.each do |order_item| 
     # discount += QuantityDiscount.determine_discount(order_item)
    end
    self.product_cost -= discount
  end
  
  
  def calculate_tax
    t = 0
    unless billing_address.nil?
      taxrate = TaxRate.find(:first, :conditions => 
                           { :state => billing_address.state })
            
      unless taxrate.nil?
        t = (taxrate.rate * self.product_cost)
      end
    
      self.tax = t
    end
    t
  end 
  
  def calculate flat_rate_shipping
    price = 0
    unless self.free_shipping
      shipping_method = ShippingMethod.find(self.shipping_method_id)
      if shipping_method && shipping_method.flat_rate_shipping
        price = shipping_method.flat_rate_shipping.base_price;
        per_item = shipping_method.flat_rate_shipping.cost_per_item;
        order_items.each do |order_item| 
        price += per_item * order_item.quantity 
      end 
        price -= per_item # compensate for first item
      end
    end
    price
  end
  
  
end
