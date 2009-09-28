require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe CartItem do
  describe "#add_product" do
    context "product has variants" do
      before(:each) do
        @product = Factory(:product)
        size = Factory(:product_option)
        color = Factory(:product_option, :name => 'color') 
        @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
        @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
        @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
        @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
        @product.product_options << [size, color]
        @cart = Cart.new
        CartItem.add_product(@cart, @product.id, 1, [@large.id, @red.id])
      end
      
      it "should add the correct variant to the cart" do
        @cart.cart_items[0].variant.product_option_selection_ids.sort == [@large.id, @red.id].sort
      end
      
      context "more quantity of the same variant is added to cart" do
        before(:each) do
          CartItem.add_product(@cart, @product.id, 1, [@large.id, @red.id])
        end
        
        it "should add to the quantity of the cart_item for variant in the cart" do
          @cart.cart_items[0].quantity.should == 2
        end
        
      end
      
    end
    
  end
end