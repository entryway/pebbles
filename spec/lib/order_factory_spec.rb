require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'
include ActionView::Helpers::NumberHelper
require File.dirname(__FILE__) + '/../cart_builder'

describe "OrderFactory" do
  describe "#create_web_order" do
    before(:each) do 
      build_variant_cart
      @cart.add_product(@variant_product.id, 1, [@large.id, @red.id])
      @cart.add_product(@product.id, 1, nil)
      @address = Factory(:address)
      @credit_card = Factory(:credit_card)
      @order = Factory(:order)
    end

    it "should create a web order" do
      OrderFactory.create_web_order(
    end
  end
end
