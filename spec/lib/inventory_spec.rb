require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'
require File.dirname(__FILE__) + '/../cart_builder'

include CartBuilder
include ActiveMerchant::Billing

describe "Inventory" do
  before(:each) do 
    configuration = GeneralConfiguration.instance
    configuration.inventory_management = true
    configuration.save!
    build_variant_cart
    @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
    @cart.add_product(@product.id, 1, nil)
    @variant = @variant_product.find_variant_by_selection_ids([@large.id, @red.id])
    @variant.update_attributes!(:inventory => 10)
  end
  
  describe "#validate_cart" do
    context "valid cart" do
      before(:each) do
        Inventory.new.validate_cart(@cart)
      end

      it "should validate a cart with items that have enough inventory" do
        @cart.errors.size.should == 0
      end
    end
    
    context "invalid cart" do
      before(:each) do
        @variant.update_attributes!(:inventory => 0)
        Inventory.new.validate_cart(@cart)
      end
      
      it "should invalidate a cart with items that are beyond the inventory availability" do
        @cart.errors.size.should_not == 0
      end
    end
  end
  
  describe "#decrease_order_inventory" do
    before(:each) do 
      @address = Factory(:address)
      @order = Factory.build(:order)
      @options = Hash.new
      @options[:billing_address] = @address.attributes
      @options[:credit_card] = {:first_name => "testing", :last_name => "tester", 
                                :number => "4012888818888", :month => "12", :year => "2011", 
                                :verification_value => "234" }
      @options[:order] = @order.attributes
      @options[:address_choice] = true
      @options[:active_shipping_method_id] = Factory(:shipping_method).id
      @order = OrderFactory.create_web_order(@cart, @options)
      @order.process
    end

    it "should decrease the inventory for order_item products of a web order" do
      @order.state.should == 'paid'
      @variant.reload.inventory.should == 9
      @product.reload.inventory.should == 9
    end
  end

end
