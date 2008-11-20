module CartsHelper 

  def default_shipping_rates(region_id)
    shipping_rates = Region.find(region_id).shipping_rates
    
    shipping_rates
  end
end