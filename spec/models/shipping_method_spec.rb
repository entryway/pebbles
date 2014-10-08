require File.dirname(__FILE__) + '/../spec_helper'

describe ShippingMethod do

  describe "#is_base_rate?" do
    let(:shipping_method) { Factory(:shipping_method)}

    it "return true when there are no flat rate shippings set and not configured for weight ranges" do
      shipping_method.is_base_rate?.should be_true
    end

    it "return true when there are not configured for weight ranges and flat rate shippings are not yet created" do
      shipping_method.flat_rate_shippings.build(Factory.build(:flat_rate_shipping).attributes)
      shipping_method.flat_rate_shippings.size.should_not eql(0)
      shipping_method.is_base_rate?.should be_true
    end

    it "returns false when using weight ranges" do
      GeneralConfiguration.instance.update_attribute(:shipping_calculation_method, 'weight')
      shipping_method.is_base_rate?.should be_false
    end

    it "returns false when shipping_method has flat_range_shippings set" do
      shipping_method.flat_rate_shippings << Factory(:flat_rate_shipping)
      shipping_method.is_base_rate?.should be_false
    end

  end

  describe "#flat_rate_by_order_total" do
    before(:each) do
      @shipping_method = Factory(:shipping_method)
      {0 => 2.99, 10.00 => 3.99, 20.00 => 4.99}.each do |k, v|
        @shipping_method.flat_rate_shippings.create(:order_total_low => k, :flat_rate => v)
      end
    end

    it "should return the correct flat_rate shipping for an order total" do
      {0 => 2.99, 9.99 => 2.99, 10 => 3.99, 15 => 3.99, 20 => 4.99, 25 => 4.99}.each do |k, v|
        @shipping_method.send(:flat_rate_by_order_total,k).should == v
      end
    end
  end

  describe "#flat_rate_by_weight_total" do
    before(:each) do
      @shipping_method = Factory(:shipping_method)
      weight_ranges = {0 => 2.99, 10 => 3.99, 20 => 4.99}
      weight_ranges.each do |k, v|
        @shipping_method.flat_rate_shippings.create(:weight_low => k, :flat_rate => v)
      end
    end

    it "should return the correct flat_rate shipping for a weight total" do
      {0 => 2.99, 9.99 => 2.99, 10 => 3.99, 15 => 3.99, 20 => 4.99, 25 => 4.99}.each do |k, v|
        @shipping_method.send(:flat_rate_by_weight_total,k).should == v
      end
    end

  end

  describe "calculate flate rate shipping cost" do
    before(:each) do
      @shipping_method            = Factory(:shipping_method)
      @flat_rate_shipping         = Factory(:flat_rate_shipping, :flat_rate => 5.0, :weight_low => 0)
      @another_flat_rate_shipping = Factory(:flat_rate_shipping, :flat_rate => 7.0, :weight_low => 10)
      @shipping_method.flat_rate_shippings = [ @flat_rate_shipping, @another_flat_rate_shipping ]
      GeneralConfiguration.stub!(:shipping_calculated_by_weight?).and_return(true)
    end
    context "using 9.9lbs weight" do
      it "should return 5 for the shipping cost" do
        cart = mock("cart")
        cart.stub!(:shipping_weight_total).and_return(9.9)
        @shipping_method.flat_rate_shipping_cost(cart).should eql(5.0)
      end
    end
    context "using 10lbs weight" do
      it "should return 7 for the shipping cost" do
        cart = mock("cart")
        cart.stub!(:shipping_weight_total).and_return(10.0)
        @shipping_method.flat_rate_shipping_cost(cart).should eql(7.0)
      end
    end
    context "using 15lbs weight" do
      it "should return 7 for the shipping cost" do
        cart = mock("cart")
        cart.stub!(:shipping_weight_total).and_return(15.0)
        @shipping_method.flat_rate_shipping_cost(cart).should eql(7.0)
      end
    end
  end

end
