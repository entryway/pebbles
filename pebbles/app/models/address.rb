class Address < ActiveRecord::Base
  #belongs_to :addressable, :polymorphic => true
  #acts_as_reportable 
  
  validates_length_of :address_1, :in => 2..100
  validates_length_of :city, :in => 2..50
  
  # state does not need to be validated
  #validates_length_of :state, :is => 2
  validates_presence_of :state
  
 # USA only support
  validates_format_of :postal_code, :with => /^\d{5}([\-]\d{4})?$|^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/,
                      :message => 'must be valid US zipcode (in the format "12345" or "12345-1234")' + 
                                  ' or valid Canadian postal code  (in the format A1A 1A1)'
  validates_presence_of :country
  
end
