require 'net/https'

class ShippingFulfillment
  # test https://fcp.efulfillmentservice.com/xml/TestXmlOrders.php
  # production https://fcp.efulfillmentservice.com/xml/XmlOrders.php
  
  def self.fulfill_order(order)
    # order.to_xml
    # post
    xml = build_efulfillment_xml(order)
    
    # move to config 2.0 style
    host = 'fcp.efulfillmentservice.com'
    path = '/xml/TestXmlOrders.php'

    puts xml.target!
        
    endpoint = Net::HTTP.new(host, 443)
    endpoint.use_ssl = true
    response = endpoint.post(path, xml.target!)
    
    if response.body =~ /ERROR/
      # an error was thrown
      puts '!ERROR!'
      # log error, order, and send email
    end
    puts response.body.to_s
  end
  
  
  def self.build_efulfillment_xml(order)
    xml = Builder::XmlMarkup.new(:encoding => 'ISO-8859-1', :indent => 2)
    xml.instruct! :xml, :version => '1.0', :encoding => 'ISO-8859-1'
    xml.declare! :DOCTYPE, :OrderList, :SYSTEM, 
                 'http://fcp.efulfillmentservice.com/xml/OrderList.dtd'
    xml.OrderList :MerchantName => 'www.12vadapters.com', :MerchantId => '787' do
      xml.Order :id => order.order_number do
        xml.AddressInfo :type => 'ship' do
          xml.Name ''
          xml.Company ''
          xml.Address1 order.shipping_address.address_1
          xml.Address2 order.shipping_address.address_2
          xml.City order.shipping_address.city
          xml.State order.shipping_address.state
          xml.Country order.shipping_address.country
          xml.Zip order.shipping_address.postal_code
          xml.Phone order.phone_number
          xml.Email ''
        end
        xml.AddressInfo :type => 'bill' do
          xml.Name ''
          xml.Company ''
          xml.Address1 order.billing_address.address_1
          xml.Address2 order.billing_address.address_2
          xml.City order.billing_address.city
          xml.State order.billing_address.state
          xml.Country order.billing_address.country
          xml.Zip order.billing_address.postal_code
          xml.Phone ''
          xml.Email ''
        end
        xml.ShippingMethod 'FC'
        x=0
        order.order_items.each do |order_item|
          xml.Item :num => x do
            xml.ProductId order_item.product.sku
            xml.Quantity order_item.quantity
            xml.tag!('Unit-Price', order_item.price)
          end
          x += 1
        end
      end
    end
    xml
  end
  
end
