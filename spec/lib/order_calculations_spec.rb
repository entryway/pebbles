require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'
include ActionView::Helpers::NumberHelper

describe OrderCalculations do 
  before(:each) do
    rate = Factory(:tax_rate)
    address = Factory(:address)
    @order = Order.new(:product_cost => 39.90, :shipping_cost => 6.45, :billing_address => address)
    @order.tax = @order.calculate_tax
  end
  
  it "should round taxrate to match ActiveMerchant" do
    number_to_currency(@order.total)[1,5].should == sprintf("%.2f", 4834.5.to_f / 100)
  end
  
end
