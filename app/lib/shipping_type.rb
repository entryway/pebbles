class ShippingType
  DEFAULT_SHIPPING = 0
  FLAT_RATE_SHIPPING = 1
  REAL_TIME_SHIPPING = 2
  FREE_SHIPPING = 3

  CONFIGURATION_SHIPPING_TYPES = { 1 => "flat rate shipping" , 2 => "real time shipping"}
  VENDOR_SHIPPING_TYPES = { 1 => "flat rate shipping" , 2 => "real time shipping",
                            3 => "free shipping"}
  PRODUCT_SHIPPING_TYPES = { 0 => "default vendor shipping", 1 => "flat rate shipping",
                             2 => "real time shipping", 3 => "free shipping" }
end