require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../order_factory'
require File.dirname(__FILE__) + '/../order_builder'




describe 'fulfillment should' do

  before(:each) do
    @order = OrderBuilder.build_order(4)
  end
  
  it 'should fulfill valid order' do
    ShippingFulfillment.fulfill_order(@order)
  end
  
end

