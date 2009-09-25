class FlatRateShipping < ActiveRecord::Base

  belongs_to :shipping_method  
  has_many :fulfillment_codes 
  
  named_scope :ordered_by_total_ranges, :order => 'order_total_low'
    
end