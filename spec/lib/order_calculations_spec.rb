require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'
include ActionView::Helpers::NumberHelper
require File.dirname(__FILE__) + '/../cart_builder'

include CartBuilder


describe OrderCalculations do

  describe "#subtotal" do
    before(:each) do
      build_variant_cart
      build_order
    end
    
    it "should add the total of the order_items prices" do
      @order.sub_total.should == 13.00
    end

    it "should subtract the discount from the product cost" do
      @order.promo_discount = 1.00
      @order.sub_total.should == 12.00
    end
    
  end

  describe "#calculate_tax" do
    before(:each) do
      rate = Factory(:tax_rate)
      @address = Factory(:address)
      @order = Order.new(:product_cost => 39.90, :shipping_cost => 6.45, :billing_address => @address)
      @order.stub!(:product_total).and_return(39.90)
      @order.tax = @order.calculate_tax
    end

    context "person lives in state with tax rate" do 

      it "should round taxrate to match ActiveMerchant" do
        number_to_currency(@order.total)[1,5].should == sprintf("%.2f", 4834.5.to_f / 100)
      end

      it "should charge the correct amount of tax" do
        @order.calculate_tax.should == 0.05 * 39.90
      end

      it "should calculate tax on the discounted price" do
        @order.promo_discount = 1.00
        @order.calculate_tax.should == 0.05 * 38.90
      end

    end
    
    context "person lives in state without tax rate" do
      before(:each) do
        @address.state = "CO"
      end

      it "should not charge tax" do
        @order.calculate_tax.should == 0
      end
      
    end
  end
  
end
