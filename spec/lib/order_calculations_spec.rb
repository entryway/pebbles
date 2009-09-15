require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe OrderCalculations do 
  before(:each) do
    rate = Factory(:taxrate)
    @order = Order.create(:product_cost => 5.99)
  end
  
  it "should round taxrate correctly" do
    @order.calculate_tax.should == 0.15
  end
  
end
