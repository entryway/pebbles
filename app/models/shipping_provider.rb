# currently not used
class ShippingProvider < ActiveRecord::Base
  belongs_to :shipping_rate

  has_one :flat_rate_shipping

end
