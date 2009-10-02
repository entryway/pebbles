require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe OrderItem do
  describe "#from_cart_item" do
    before(:each) do
      product = Factory(:product)
    end
    it "should create a cart item from an order item"
  end
end
