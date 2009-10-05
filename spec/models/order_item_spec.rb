require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe OrderItem do
  describe "#from_cart_item" do
    context "regular product" do
      before(:each) do
        @product = Factory(:product)
        @cart_item = Factory(:cart_item, :product => @product)
        @order_item = OrderItem.from_cart_item(@cart_item)
      end

      it "should create an order item from a cart item for a regular product" do
        @order_item.price.should == @product.price
        @order_item.product_name.should == @product.name
        @order_item.quantity.should == @cart_item.quantity
        @order_item.weight.should == @product.weight
      end
    end

    context "variant product" do
      before(:each) do
        @product = Factory(:product)
        @variant_product = Factory(:product)
        size = Factory(:product_option)
        color = Factory(:product_option, :name => 'color') 
        @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
        @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
        @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
        @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
        @variant_product.product_options << [size, color]
        @cart = Cart.create(:name => 'test')
        @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
        @order_item = OrderItem.from_cart_item(CartItem.first)
      end

      it "should create an order item from a cart item for a variant product" do
        variant = @variant_product.find_variant_by_selection_ids([@large.id, @red.id])
        @order_item.price.should == variant.price
        @order_item.product_name.should == @variant_product.name
        @order_item.quantity.should == 1
        @order_item.weight.should == @variant_product.weight
      end
    end

  end
end
