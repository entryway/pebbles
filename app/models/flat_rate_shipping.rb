class FlatRateShipping < ActiveRecord::Base

  belongs_to :shipping_method  
  has_many :fulfillment_codes 
  
  def calculate_shipping_totals
    
  end
  
end