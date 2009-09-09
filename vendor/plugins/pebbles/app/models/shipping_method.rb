class ShippingMethod < ActiveRecord::Base
  belongs_to :regions
  
  has_one :flat_rate_shipping
  has_many :fulfillment_codes
  
  validates_presence_of :name 


end


