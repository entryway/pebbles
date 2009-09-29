require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe ShippingMethod do
  describe "#flat_rate_by_order_total" do
    before(:each) do
      @shipping_method = Factory(:shipping_method)
      {0 => 2.99, 10.00 => 3.99, 20.00 => 4.99}.each do |k, v|
        @shipping_method.flat_rate_shippings.create(:order_total_low => k, :flat_rate => v)
      end
    end
    
    it "should return the correct flat_rate shipping for an order total" do
      {0 => 2.99, 9.99 => 2.99, 10 => 3.99, 15 => 3.99, 20 => 4.99, 25 => 4.99}.each do |k, v|
        @shipping_method.flat_rate_by_order_total(k).should == v
      end
    end
  end
  
end
