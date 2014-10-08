require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../cart_builder'

include CartBuilder

describe Cart do
  before(:each) do
    build_variant_cart
  end
  describe "#find_product_or_variant" do

    it "should return a cart item when one containts same product" do
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :quantity => 1)
      @cart.find_product_or_variant(@product, nil).should == @cart_item
    end

    it "should return a cart item when one contains same variant" do
      variant = @variant_product.find_variant_by_selection_ids([@large.id, @red.id])
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :variant_id => variant.id,
                                           :quantity => 1)
      @cart.find_product_or_variant(@product, variant).should == @cart_item
    end

    it "should return nil when the variant is not in the cart" do
      variant = @variant_product.find_variant_by_selection_ids([@large.id, @red.id])
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :variant_id => variant.id)
      new_variant = @product.find_variant_by_selection_ids([@large.id, @blue.id])
      @cart.find_product_or_variant(@product, new_variant).should be_nil
    end

  end

  describe "#tax_total" do
    before(:each) do
      rate = Factory(:tax_rate)
      @cart_item = @cart.cart_items.create(:product_id => @product.id, :quantity => 1)
      @cart.billing_state = rate.state
    end

    it "should calculate tax" do
      @cart.tax_total.should == 5.50 * 0.05
    end

    it "should calculate tax after promo code applied" do
      @cart.promo_discount = 1.00
      @cart.tax_total.should == 4.50 * 0.05
    end
  end
end

describe Cart do
  describe "#weight_total" do
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

end
