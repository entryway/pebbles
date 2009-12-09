include ActiveMerchant::Billing

class OrderFactory
  
  WEB_ORDER_DEFAULTS = { :order_type => OrderType::WEB, :payment_type => 'credit_card', :delivery_status => 1 }
  
  class << self
    
    # create an order from a paypal notification 
    # Exception::EbayOrderException thrown if an issue is encountered
    def create_ebay_order(notify)

      billing_address = Address.new(
        :address_1   => notify.address_street,
        :address_2   => '',
        :city        => notify.address_city,
        :state       => notify.address_state,
        :postal_code => notify.address_zip,
        :country     => notify.address_country_code
      )
      shipping_address = Address.new(
        :address_1   => notify.address_street,
        :address_2   => '',
        :city        => notify.address_city,
        :state       => notify.address_state,
        :postal_code => notify.address_zip,
        :country     => notify.address_country_code
      )
      
      order = Order.new
      order.order_type = OrderType::EBAY
      order.build_order_number('E')
      # TODO: do addresses need to be validated before saving?
      unless billing_address.save
        errors = billing_address.errors.collect { |e| e }
        msg = "eBay Error: Invalid billing address: #{errors},
               #{DateTime.now}, auction buyer id: #{notify.auction_buyer_id}, 
               item number: #{notify.item_number}."
         order.admin_notes = msg
         order.issue_raised!
         order.issue_raised!
        raise Exceptions::EbayOrderException, msg, caller  
      end
      unless shipping_address.save
        errors = billing_address.errors.collect { |e| e }
        msg = "eBay Error: Invalid billing address: #{errors},
               #{DateTime.now}, auction buyer id: #{notify.auction_buyer_id}, 
               item number: #{notify.item_number}."
        order.admin_notes = msg
        order.issue_raised!
        order.issue_raised!
        raise Exceptions::EbayOrderException, msg, caller
      end
      order.billing_address = billing_address
      order.shipping_address = shipping_address
      order.full_name = notify.first_name + ' ' + notify.last_name
      order.email = notify.payer_email
      order.business = notify.payer_business_name
      order.ebay_auction_id = notify.auction_buyer_id
      order.ebay_item_number = notify.item_number
      order.phone_number = '555-555-5555'
    
      # create order items
      for i in (1...notify.num_cart_items+1)
        name = notify.item_name(i)
        sku = grab_sku(name)
        quantity = notify.item_quantity(i)
        product = product_from(sku)
        if product
          order.order_items << OrderItem.from_ebay_order(product, quantity)
        else
          msg = "eBay Error: Product received from eBay is not a valid product: #{notify.item_name(i)},
                 #{DateTime.now}, auction buyer id: #{notify.auction_buyer_id}, 
                 item number: #{notify.item_number}." 
          order.admin_notes = msg
          order.issue_raised!
          order.issue_raised!
          raise Exceptions::EbayOrderException, msg, caller
        end
      end
      order = shipping_method_translation(order, billing_address.country, notify)      
      order.calculate_order_costs
      
      order.save!   # raise exception if error
       
      order
    end
    
    # build a paypal order
    def create_paypal_order(cart, details, active_shipping_region_id, active_shipping_method_id)
      order = Order.new 
      order.order_type = OrderType::WEB
      billing_address = Address.new(
        :address_1   => details.address['address1'],
        :address_2   => details.address['address2'],
        :city        => details.address['city'],
        :state       => details.address['state'],
        :postal_code => details.address['zip'],
        :country     => details.address['country']
      )
      shipping_address = Address.new(
        :address_1   => details.address['address1'],
        :address_2   => details.address['address2'],
        :city        => details.address['city'],
        :state       => details.address['state'],
        :postal_code => details.address['zip'],
        :country     => details.address['country']
        )
      order.business = ''
      order.billing_address = billing_address
      order.shipping_address = shipping_address
      order.full_name = details.name
      order.phone_number = '555-555-5555'
      order.email = details.email
      
      order.shipping_method_id = active_shipping_method_id
      order.region_id = active_shipping_region_id
      order.add_order_items_from_cart(cart)
      
      order.payment_type = 'paypal'
      
      order.save! 
      
      order
    end
    
    
    # build a web order
    def create_web_order(cart, options = {})
        
      order = Order.new(WEB_ORDER_DEFAULTS.merge(options[:order]))     
      billing_address = Address.new(options[:billing_address])
      
      # piece-meal validation so user sees validation in steps
      
      # shipping address?
      shipping_same = true unless options[:address_choice].nil?
      unless shipping_same
        shipping_address = Address.new(options[:shipping_address])
      else
        shipping_address = billing_address.clone
      end
      
      order.shipping_address = shipping_address 
      order.billing_address = billing_address

      # CC validation 
      credit_card = CreditCard.new(options[:credit_card])
      credit_card.require_verification_value = true
      order.credit_card = credit_card
      valid = cart.valid? && credit_card.valid? && order.valid? &&
        billing_address.valid? && shipping_address.valid?
      if valid
        order.credit_card_display = order.credit_card.display_number
                
        order.shipping_method_id = options[:active_shipping_method_id]
        order.region_id = options[:active_shipping_region_id]
        order.add_order_items_from_cart(cart)
        promo = PromoCode.find_by_code(options[:order][:promo_code])
        promo.apply(order) if promo
        order.calculate_order_costs
      else
        order.invalid = true
      end
      order
    end
    
  private 
   
      # set the region and shipping method by region
      def shipping_method_translation(order, country, notify)
        # shipping method is same as standard shipping, United States
        case country
        when "US"
          trying_region = "United States"
          trying_method = "Standard (3-5 Bus. Days)"
          region = Region.find_by_name(trying_region)
          shipping_method = ShippingMethod.find_by_name(trying_method)
        when "CA"
          trying_region = "Canada"
          trying_method = "First Class"
          region = Region.find_by_name(trying_region)
          shipping_method = ShippingMethod.find_by_name(trying_method)
        else
          # International catch-all
          trying_region = "International"
          trying_method = "Standard International"
          region = Region.find_by_name(trying_region)
          shipping_method = ShippingMethod.find_by_name(trying_method)
        end
        if region
          order.region_id = region.id
        else
         msg = "eBay Error: Region not found: #{order.billing_address.country},
                 #{DateTime.now}, auction buyer id: #{notify.auction_buyer_id}, 
                 trying region #{trying_region}, trying method #{trying_method}" 
          order.admin_notes = msg
          order.issue_raised!
          order.issue_raised!
          raise Exceptions::EbayOrderException, msg, caller
        end
        if shipping_method
          order.shipping_method_id = shipping_method.id
          order.shipping_method = shipping_method.name
        else
          msg = "eBay Error: Shipping Method not found: #{order.billing_address.country},
                  #{DateTime.now}, auction buyer id: #{notify.auction_buyer_id}, 
                  trying region #{trying_region}, trying method #{trying_method}" 
           order.admin_notes = msg
           order.issue_raised!
           order.issue_raised!
           raise Exceptions::EbayOrderException, msg, caller
        end    
        order
      end
      
      # find a product by sku
      def product_from(sku)
        product = Product.find(:first, :conditions => { :sku => sku })
      end
      
      # parse a sku out of the ebay product subject
      def grab_sku(name)
        if name 
          # TODO: use regexp
          i1 = name.index('(')
          i2 = name.index(')')
          if i1 && i2
            sku = name.split('(')[1]
            sku = sku.split(')')[0] if sku
          end
          sku.gsub(/\s/, '')  # remove spaces
        end
      end
      
  end
end
