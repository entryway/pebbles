module Pebbles::Admin::ShippingMethodsHelper
  def add_fulfillment_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :fulfillment_codes, 
      :partial => 'fulfillment_code',
      :object => FulfillmentCode.new
    end
  end
  
  def set_up_shippping_method(shipping_method)
    returning(shipping_method) do |m|
      10.times do 
        m.flat_rate_shippings.build
      end
    end
  end
  
  
end
