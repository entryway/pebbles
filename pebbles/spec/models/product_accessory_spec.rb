require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe ProductAccessory do 
  before(:each) do 
    #ShippingCalculations.stub!(:quote_packages).and_return(5)
    Factory(:configuration)
    @cart = Cart.new
    @product1 = Factory(:product, :flat_rate_shipping => 1)
    @product2 = Factory(:product, :flat_rate_shipping => 2)
    @vendor = Factory(:vendor)
    @product1.vendor = @vendor
    @product2.vendor = @vendor
    @product1.accessories << @product2
    product_accessory = ProductAccessory.first
    product_accessory.price_adjustment = -1
    product_accessory.save
    @product1.save
    @product2.save
    CartItem.add_product(@cart, @product1.id, 1, nil)
    CartItem.add_to_cart(@cart, nil, @product2.id, 1, nil, product_accessory.id)
    @cart.save
  end
  
  it "it should adjust the product price in the cart" do
    @cart.sub_total.should == 10
  end
  
end
    
