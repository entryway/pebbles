class Configuration < ActiveRecord::Base
  FLAT_RATE_SHIPPING = 1
  REAL_TIME_SHIPPING = 2
  SHIPPING_TYPES = { 1 => "flat rate shipping" , 2 => "real time shipping"}
end