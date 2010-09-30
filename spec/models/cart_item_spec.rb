require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../cart_builder'

include CartBuilder

describe CartItem do

  before(:each) do
    build_variant_cart
  end

  describe "#add_product" do
    before(:each) do
      @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
    end
    context "product has variants" do

      it "should add the correct variant to the cart" do
        @cart.cart_items[0].variant.product_option_selection_ids.sort == [@large.id, @red.id].sort
      end

      context "more quantity of the same variant is added to cart" do
        before(:each) do
          @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
        end

        it "should add to the quantity of the cart_item for variant in the cart" do
          @cart.cart_items[0].quantity.should == 2
        end

      end
    end
  end

  describe "#price"
    it "should return the price of the product if cart_item is not a variant" do
      @cart.add_product(@product.id, 1, nil)
      @cart.cart_items[0].price.should == @product.price
    end

    it "should return the price of the variant if cart_item is a variant" do
      variant = @variant_product.find_variant_by_selection_ids([@large.id, @red.id])
      variant.price = 10.25
      variant.save!
      @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
      @cart.cart_items[0].price.should == variant.price
    end

end
