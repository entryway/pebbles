require File.dirname(__FILE__) + '/../spec_helper'


describe 'Promo codes ' do

  before(:each) do
    @promo_code = Factory(:promo_code)
   # @order = Factory(:order)
    @order = Order.new
    @order.product_cost = 0
    @order.shipping_cost = 0
    @order.email = 'blah@blah.com'
    @order.drop_shipping_cost = 0
    @order.tax = 0
    @order.full_name = 'fred smith'
    @order.order_type = '1'
    @order.promo_discount = 0
  end
  
  it 'applies to orders exceeding the minimum amount required' do
    @promo_code.minimum_order_amount = 60.00
    @order.stub!(:sub_total).and_return(60.00)
    message = @promo_code.apply(@order)
    message.should == PromoCode::SUCCESS_MESSAGE
  end
  
  it 'fails to apply to orders not reaching the minimum amount required' do
    @promo_code.minimum_order_amount = 60.00
    @order.stub!(:sub_total).and_return(59.00)
    message = @promo_code.apply(@order)
    message.should == @promo_code.minimum_amount_required_message
  end
  
  it 'activates free shipping' do
    @promo_code.free_shipping = true
    @order.stub!(:sub_total).and_return(59.00)
    @order.free_shipping = false
    
    message = @promo_code.apply(@order)
    @order.free_shipping.should == true
    message.should == PromoCode::SUCCESS_MESSAGE
  end
  
  it 'applies dollar discount' do
    @promo_code.dollar_discount = 5.00
    @order.product_cost = 55.00
    
    message = @promo_code.apply(@order)
    @order.total.should == sprintf("%.2f", 50.00) 
    message.should == PromoCode::SUCCESS_MESSAGE
  end
  
  it 'applies percentage discount' 
  
end

