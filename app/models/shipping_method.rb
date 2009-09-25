class ShippingMethod < ActiveRecord::Base
  belongs_to :regions
  
  has_many :flat_rate_shippings, :dependent => :destroy
  has_many :fulfillment_codes
  
  validates_presence_of :name 
  
  accepts_nested_attributes_for :flat_rate_shippings, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['flat_rate'].blank? }

  ##
  # returns the shipping rate of the flat_rate_shippings with the highest order_total_low
  # that is less than or equal to the order_total for the shipping method
  #
  # @param[Float] total order_total
  # @return[Float] flat_rate of the flat_rate_shipping
  def flat_rate_by_order_total(total)
    shipping = self.flat_rate_shippings.ordered_by_total_ranges.find(:last, 
                                                                     :conditions => "order_total_low <= #{total}")
    shipping.flat_rate
  end
    
    

end


