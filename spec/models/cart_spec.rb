require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe Cart do
  describe "#find_product_or_variant" do
    before(:each) do
      @product = Factory(:product)
      @cart = Cart.create(:name => 'test')
      size = Factory(:product_option)
      color = Factory(:product_option, :name => 'color') 
      @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
      @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
      @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
      @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
      @product.product_options << [size, color]
    end
    
    it "should return a cart item when one containts same product" do
      @cart_item = @cart.cart_items.create(:product_id => @product.id)
      @cart.find_product_or_variant(@product, nil).should == @cart_item
    end

    it "should return a cart item when one contains same variant" do
      variant = @product.find_variant_by_selection_ids([@large.id, @red.id])
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :variant_id => variant.id)
      @cart.find_product_or_variant(@product, variant).should == @cart_item
    end
    
    it "should return nil when the variant is not in the cart" do
      variant = @product.find_variant_by_selection_ids([@large.id, @red.id])
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :variant_id => variant.id)
      new_variant = @product.find_variant_by_selection_ids([@large.id, @blue.id])
      @cart.find_product_or_variant(@product, new_variant).should be_nil
    end
            
  end
end
