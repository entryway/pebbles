
class Order < ActiveRecord::Base
  include ActiveMerchant::Billing
  include OrderCalculations 
  include OrderProcessing
  acts_as_reportable
  

  belongs_to :billing_address,
             :class_name => 'Address',
             :foreign_key => 'billing_address_id'
  belongs_to :shipping_address,
             :class_name => 'Address',
             :foreign_key => 'shipping_address_id'
                        
  has_many :order_items 
  has_many :transactions,
           :class_name => 'OrderTransaction',
           :dependent => :destroy

  attr_accessor :payment_type  # not currently saved, future
  attr_accessor :credit_card
  attr_accessor :region_id
  
  #protect these fields from values that were
  #inserted into the request intentionally
  attr_protected :id, :credit_card, :customer_ip, :updated_at, :created_at
  
  #contact detail validation
  validates_presence_of :full_name
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => 'should be in the form of someone@somewhere.com' 
  # international
  # validates_format_of :phone_number, :with => /^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,5})|(\(?\d{2,6}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$/
  #validates_presence_of :phone_number
  validates_presence_of :order_type 
  
#  validates_length_of :customer_ip, :in => 7..15 

  before_save :determine_shipping_method
  
 
  # bummer ultrasphinx screws has_finder up, wait till rails 2.1 or move to plugins
  #has_finder :ebay_orders,
  #              :conditions => { :order_type => OrderType::EBAY },
  #              :order => 'id'
                
  #has_finder :web_orders,
  #              :conditions => { :order_type => OrderType::WEB },
  #              :order => 'id'

  # ultrasphinx
  #is_indexed :fields => ['id', 'order_number', 'business', 'created_at',
  #                       'state', 'full_name', 'email', 'phone_number',
  #                       'ebay_item_number', 'ebay_auction_id'],
  #           :include => [{:association_name => 'shipping_address', :field => 'address_1'},
  #                        {:association_name => 'shipping_address', :field => 'address_2'},
  #                        {:association_name => 'shipping_address', :field => 'state'},
  #                       {:association_name => 'shipping_address', :field => 'country'},
  #                        {:association_name => 'shipping_address', :field => 'postal_code'},
  #                        {:association_name => 'billing_address', :field => 'address_1'},
  #                        {:association_name => 'billing_address', :field => 'address_2'},
  #                        {:association_name => 'billing_address', :field => 'state'},
  #                        {:association_name => 'billing_address', :field => 'country'},
  #                        {:association_name => 'billing_address', :field => 'postal_code'}]
  
                                               
  def add_order_items_from_cart(cart)
    cart.cart_items.each do |item|
      oi = OrderItem.from_cart_item(item)
      self.order_items << oi
    end    
    
    self.calculate_order_costs
  end
  
  # count all the order items, taking into consideration quantity
  def total_order_items
    count = 0
    self.order_items.each do |order_item|
      count += order_item.quantity
    end
    count
  end
  
  def build_order_number(prefix)
    self.order_number = prefix + "-" + self.id.to_s
    order_number
  end
  
  def Order.web_orders
    self.find(:all, :conditions => { :order_type => OrderType::WEB },
              :order => 'id DESC')
  end
                                 
  def Order.ebay_orders
    self.find(:all, :conditions => { :order_type => OrderType::EBAY },
              :order => 'id DESC')    
  end
  
  ## Order States
  acts_as_state_machine :initial => :pending

  state :pending 
  state :authorized
  state :paid 
  state :payment_declined 
  state :refunded
  state :disputed
  state :shipping_delayed
  state :fulfilled
  state :shipped
  state :issue
  
  # state events 
  event :payment_authorized do
    transitions :from => :pending,
                :to => :authorized
                          
    transitions :from => :payment_declined,
                :to => :authorized
  end
  
  event :payment_captured do
    transitions :from => :authorized,
                :to   => :paid
  end
  
  event :transaction_declined do
    transitions :from => :pending,
                :to   => :payment_declined
                
    transitions :from => :payment_declined,
                :to   => :payment_declined
  end
  
  event :issue_raised do
    transitions :from => :pending,
                :to => :issue
                
    transitions :from => :paid,
                :to => :issue
                
    transitions :from => :authorized, 
                :to => :issue
  end
  
  event :shipping_fulfilled do
    transitions :from => :paid,
                :to => :fulfilled
          
    transitions :from => :pending,
                :to => :fulfilled
  end
  
  event :shipping_delayed do
    transitions :from => :pending,
                :to => :shipping_delayed
                
    transitions :from => :paid,
                :to => :shipping_delayed
  end
  

protected 

  def determine_shipping_method
    if self.shipping_method_id
      begin
        self.shipping_method = ShippingMethod.find(self.shipping_method_id)
      rescue
        self.shipping_method = ShippingMethod.new
      end
      if self.shipping_method
        self.shipping_method = self.shipping_method.name
      end
    end
  end
    
  def validate
     if full_name.nil?
         errors.add(:full_name, "must contain a first and last name.") if ! full_name.include? ' '
     end
  end
end
