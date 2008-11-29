class Configuration < ActiveRecord::Base
  SHIPPING_TYPES = { 1 => "flat rate shipping" , 2 => "real time shipping"}
end