class FlatRateShipping < ActiveRecord::Base
  belongs_to :shipping_rate
  
  has_many :fulfillment_codes 
  
  def calculate_shipping_totals
    
  end
  
end