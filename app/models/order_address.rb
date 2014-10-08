class OrderAddress < ActiveRecord::Base

  validates_length_of :address_1, :in => 2..50
  validates_length_of :city, :in => 2..50
  validates_length_of :state, :is => 2
  validates_format_of :postal_code, :with => /^\d{5}([\-]\d{4})?$/,
                      :message => 'should be in the format "12345" or "12345-1234"'

end
