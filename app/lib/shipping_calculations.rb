require 'shipping'

class ShippingCalculations
  
  def self.quote(product_id, quantity, zipcode)
    product = Product.find(product_id)
    ups = Shipping::UPS.new :zip => zipcode, :sender_zip => product.vendor.zipcode, :weight => quantity * product.weight
    quote = ups.price
  end
end