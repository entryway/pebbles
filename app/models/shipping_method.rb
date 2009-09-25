class ShippingMethod < ActiveRecord::Base
  belongs_to :regions
  
  has_many :flat_rate_shippings, :dependent => :destroy
  has_many :fulfillment_codes
  
  validates_presence_of :name 
  
  accepts_nested_attributes_for :flat_rate_shippings, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['flat_rate'].blank? }
                                
  def flat_rate_by_order_total(total)
    self.flat_rate_shippings.ordered_by_total_ranges
  end
    
    

end


