module Exceptions
  class OrderException < RuntimeError; end
  class EbayOrderException < RuntimeError; end
  class WebOrderException < RuntimeError; end
  
  class FulfillmentException < RuntimeError; end
end