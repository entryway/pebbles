require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe ShippingCalculations do 

  describe "#weight_total" do
    context "for cart" do
      before(:each) do
        product1 = Factory(:product, :weight => 2.5)
        @product2 = Factory(:product, :weight => 3.5)
        @cart = Factory(:cart)
        @cart.cart_items.create(:product_id => product1.id, :quantity => 1)
        @cart.cart_items.create(:product_id => @product2.id, :quantity => 2)
      end

      it "should calculate sum of product weights multiplied by quantity ordered" do
        @cart.shipping_weight_total.should eql(9.5)
      end

      it "should not include free shipping in the weight total" do
        @product2.update_attribute(:free_shipping, true)
        @cart.shipping_weight_total.should eql(2.5)
      end
    end
    context "for order" do
      before(:each) do
        product1 = Factory(:product, :weight => 2.5)
        @product2 = Factory(:product, :weight => 3.5)
        @order = Factory(:order)
        @order.order_items.create(:product_id => product1.id, :quantity => 1)
        @order.order_items.create(:product_id => @product2.id, :quantity => 2)
      end

      it "should calculate sum of product weights multiplied by quantity ordered" do
        @order.shipping_weight_total.should eql(9.5)
      end

      it "should not include free shipping in the weight total" do
        @product2.update_attribute(:free_shipping, true)
        @order.shipping_weight_total.should eql(2.5)
      end
    end
  end

  # before(:each) do 
  #    #ShippingCalculations.stub!(:quote_packages).and_return(5)
  #    Factory(:configuration)
  #    @cart = Cart.new
  #    @product1 = Factory(:product, :flat_rate_shipping => 1)
  #    @product2 = Factory(:product, :flat_rate_shipping => 2)
  #    @vendor = Factory(:vendor)
  #    @product1.vendor = @vendor
  #    @product2.vendor = @vendor
  #    @product1.save
  #    @product2.save
  #    CartItem.add_product(@cart, @product1.id, 1, nil)
  #    CartItem.add_product(@cart, @product2.id, 1, nil)
  #    @cart.save
  #  end
  #  
  #  it "should calculate free shipping for a product" do
  #    @vendor.shipping_type = ShippingType::FREE_SHIPPING
  #    @vendor.save
  #    quote = ShippingCalculations.product_quote(@product1.id, 1, '24091')
  #    quote.should == 0
  #  end
  #   
  #  it "should calculate flat-rate shipping for a product" do
  #    @vendor.shipping_type = ShippingType::FLAT_RATE_SHIPPING
  #    @vendor.save
  #    quote = ShippingCalculations.product_quote(@product1.id, 1, '24091')
  #    quote.should == 1
  #  end 
  # 
  #  it "should calculate real-time shipping for a product" do
  #    @vendor.shipping_type = ShippingType::REAL_TIME_SHIPPING
  #    @vendor.save
  #    quote = ShippingCalculations.product_quote(@product1.id, 1, '24091')
  #    quote.should_not == 0 || 1
  #    quote_with_accessory = ShippingCalculations.product_quote(@product1.id, 1, '24091',[ @product2 ])
  #    quote_with_accessory.should == quote * 2 
  #  end 
  #    
  #  it "should calculate free shipping for a cart" do
  #    @vendor.shipping_type = ShippingType::FREE_SHIPPING
  #    @vendor.save
  #    @cart.shipping_totals(nil, nil, nil).should == 0
  #  end
  #  
  #  it "should calculate flat-rate shipping for a cart" do
  #    @vendor.shipping_type = ShippingType::FLAT_RATE_SHIPPING
  #    @vendor.save
  #    @cart.shipping_totals(nil, nil, nil).should == 3
  #  end
  #  
  #  it "should calculate real-time shipping for a cart" do
  #    @vendor.shipping_type = ShippingType::REAL_TIME_SHIPPING
  #    @vendor.save
  #    two_product_shipping_total = @cart.shipping_totals(nil, nil, '24091')
  #    two_product_shipping_total.should_not == 0 || 3
  #    @cart.cart_items.delete(@cart.cart_items[0])
  #    one_product_shipping_total = @cart.shipping_totals(nil, nil, '24091')
  #    two_product_shipping_total.should == 2 * one_product_shipping_total
  #  end
  
  describe "Flat Rate Shipping calculations" do
    before(:each) do
      GeneralConfiguration.instance
      @shipping_method = Factory(:shipping_method)
      {0 => 2.99, 10.00 => 3.99, 20.00 => 4.99}.each do |k, v|
        @shipping_method.flat_rate_shippings.create(:flat_rate => v, :order_total_low => k)
      end
      product1 = Factory(:product)
      product2 = Factory(:product)
      @cart = Cart.new
      @cart.add_product(product1.id, 1, nil)
      @cart.add_product(product2.id, 1, nil)
      @cart.shipping_method_id = @shipping_method.id
      @order = Factory(:order, :shipping_method_id => @shipping_method.id)
      @cart.cart_items.each do |item|
        oi = OrderItem.from_cart_item(item)
        @order.order_items << oi
      end
    end

    context "using flat rate by order total" do
      it "should calculate flat_rate shipping for an order" do
        @order.calculate_shipping_costs.should == 3.99
      end

      it "should calculate flat_rate shipping for a discounted order" do
        @order.promo_discount = 2.00
        @order.calculate_shipping_costs.should == 2.99
      end

      it "should calculate flat_rate shipping for a cart" do
        @cart.calculate_shipping_costs.should == 3.99
      end

      it "should calculate flat_rate shipping for a discounted cart" do
        @cart.promo_discount = 2.00
        @cart.calculate_shipping_costs.should == 2.99
      end

    end

    context "using flat rate by base rate" do
      it "should calculate flat_rate shipping for an order" do
        @shipping_method.flat_rate_shippings.delete_all
        @order.calculate_shipping_costs.should == 6.00
      end
    end
    
  end
  
    

  describe 'Specified products have free shipping:' do

    context 'Flat Rate Shipping calculations' do

      before(:each) do
        GeneralConfiguration.instance
        @shipping_method = Factory(:shipping_method)
        { 0 => 2.99, 10.00 => 3.99, 20.00 => 4.99 }.each do |k, v|
          @shipping_method.flat_rate_shippings.create(:flat_rate => v, :order_total_low => k)
        end
        @product1 = Factory(:product, :price => '5.5', :free_shipping => true)
        @product2 = Factory(:product, :price => '5.5')

        @cart = Cart.new
        @cart.add_product(@product1.id, 1, nil)
        @cart.add_product(@product2.id, 1, nil)
        @cart.shipping_method_id = @shipping_method.id

        @order = Factory(:order, :shipping_method_id => @shipping_method.id)
        @cart.cart_items.each do |item|
          oi = OrderItem.from_cart_item(item)
          @order.order_items << oi
        end
      end

      it 'total does not include products marked for free shipping' do
        @order.calculate_shipping_costs.should == 2.99
      end

      it 'total does not include products marked for free shipping with more than one product' do
        cart_item = @cart.add_product(@product1.id, 1, nil)
        oi = OrderItem.from_cart_item(cart_item)
        @order.order_items << oi

        @order.calculate_shipping_costs.should == 2.99
      end

    end

  end



end
  
