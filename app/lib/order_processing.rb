# Handle processing of an order
module OrderProcessing 
    
    # process the order with the current merchant
    def process
      if self.order_items.size > 0 
        case self.order_type
        when OrderType::WEB
          process_web_order
        when OrderType::EBAY
          process_ebay_order
        else
          raise Exception::OrderException, "Invaild order type. Order not processed."
        end
      end
    end
    
    # make an authorization on a payment
    def authorize_payment(options = {})
      options = populate_options if options.size == 0
      options[:order_id] = self.order_number
      transaction do
        authorization = OrderTransaction.authorize(self.total_in_cents, 
                                                   self.credit_card, options
                        )
        self.transactions << authorization
        if authorization.success?
          # TODO: something seems odd with acts_as_state_machine and
          # 2.0.2, saving twice works?????
          payment_authorized!
        else
          transaction_declined!
        end
        authorization
      end
    end

    # return the authorized reference for further use
    def authorization_reference
      if authorization = transactions.find_by_action_and_success('authorization', 
                                                                 true, :order => 'id ASC')
        authorization.reference
      end
    end

    ##
    # Capture funds for this order
    #
    # @params[Hash] Options hash that takes shipping_address, billing_address, etc.
    #    amount is a member of the hash to overide to deafult self.total_in_cents
    def capture_payment(options = {})
      options = populate_options if options.size == 0
      options[:amount] ||= self.total_in_cents
      transaction do
        capture = OrderTransaction.capture(options[:amount], authorization_reference, options)
        self.transactions << capture
        if capture.success?
          payment_captured!
        else
          transaction_declined!
        end
        capture
      end
    end
    
private
    
    # TODO: move to acts_as_state_machine transitions
    def initialize_order
      save!
      case self.order_type
      when OrderType::WEB
        prefix = "W"
      when OrderType::EBAY
        prefix = "E"
      else
        prefix = "U"
      end
      build_order_number(prefix)
    end
  
    def process_ebay_order
      initialize_order
      # send off to integration
      ShippingFulfillment.fulfill_order(self)
    end
     
    def process_web_order
      initialize_order
      puts "*"*80
      puts "in here"
      
      if self.payment_type == 'credit_card'
        process_with_active_merchant

        unless self.paid? || self.authorized?
          msg = self.transactions[0].params['error']
          raise Exceptions::OrderException, msg, caller
        end
                
        if APP_CONFIG['fulfillment'] == true
          if self.paid?
            ShippingFulfillment.fulfill_order(self)
          else
            msg = self.transactions[0].message
              raise Exceptions::OrderException, msg, caller
            end
          elsif self.payment_type == 'paypal'
            begin 
              ShippingFulfillment.fulfill_order(self)
            rescue 
            end
          end 
        end
      
        OrderNotifier.deliver_order_confirmation(self, self.email, '128.9.0.0')
        OrderNotifier.deliver_supplier_confirmation(self, self.email, '128.9.0.0')
    end

    def populate_options
      options = {
        :billing_address => {
          :address1 => self.billing_address.address_1,
          :address2 => self.billing_address.address_2,
          :city => self.billing_address.city,
          :state => self.billing_address.state,
          :zip => self.billing_address.postal_code,
          :country => self.billing_address.country,
          :phone => self.phone_number
        },
        :shipping_address => {
          :address1 => self.shipping_address.address_1,
          :address2 => self.shipping_address.address_2,
          :city => self.shipping_address.city,
          :state => self.shipping_address.state,
          :zip => self.shipping_address.postal_code,
          :country => self.shipping_address.country,
          :phone => self.phone_number
        },
        :company => self.business, 
        :order_id => self.id,
        :customer => self.full_name,
        :email => self.email
      }
    end
    
    # Active Merchant order processing
    def process_with_active_merchant
      options = populate_options
      auth = authorize_payment(options)
      save!
      if APP_CONFIG['pre_and_post_authorization'] == true
        if auth.success == true
          capture_payment(options)
          save!
        end
      end
    end
    
end