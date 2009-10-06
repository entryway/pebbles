require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'
include ActionView::Helpers::NumberHelper
require File.dirname(__FILE__) + '/../cart_builder'

include CartBuilder
include ActiveMerchant::Billing

describe "OrderFactory" do
  describe "#create_web_order" do
    before(:each) do 
      build_variant_cart
      @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
      @cart.add_product(@product.id, 1, nil)
      @address = Factory(:address)
      @order = Factory.build(:order)
      @options = Hash.new
      @options[:billing_address] = @address.attributes
      @options[:credit_card] = {:first_name => "testing", :last_name => "tester", 
                                :number => "4111111111111111", :month => "12", :year => "2011", 
                                :verification_value => "234" }
      @options[:order] = @order.attributes
      @options[:address_choice] = true
      @options[:active_shipping_method_id] = Factory(:shipping_method).id
    end

    it "should create a web order" do
      order = OrderFactory.create_web_order(@cart, @options)
      order.order_items.size.should == 2
    end
  end
end
