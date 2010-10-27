require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  describe "#generate_variants" do
    before(:each) do
      @product = Factory(:product)
      size = Factory(:product_option)
      color = Factory(:product_option, :name => 'color')
      @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
      @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
      @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
      @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
      @product.product_options << [size, color]
    end
    it "should generate a cartesian product of variants" do
      puts
      @product.variants.size.should == 4
    end

    it "should adjust the price of the variants" do
      variant = @product.variants.first
      variant.price.should == 7.50
    end

    it "should adjust the weight of the variants" do
      variant = @product.variants.first
      variant.weight.should == 3.00
    end

    it "should transfer the product sku" do
      variant = @product.variants.first
      variant.sku.should == @product.sku
    end
  end

  describe "#find_variant_by_selection_ids" do
    before(:each) do
      @product = Factory(:product)
      size = Factory(:product_option)
      color = Factory(:product_option, :name => 'color')
      @large = Factory(:product_option_selection, :name => 'large', :product_option => size)
      @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
      @red = Factory(:product_option_selection, :name => 'red', :product_option => color)
      @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
      @product.product_options << [size, color]
    end

    it "should find the correct variant for a set of selections" do
      variant = @product.find_variant_by_selection_ids([@red.id, @small.id])
      variant.product_option_selections.each do |s|
        [@red.id, @small.id].should include(s.id)
      end
    end

    it "should return nil if there isn't any selection_ids" do
      variant = @product.find_variant_by_selection_ids(nil)
      variant.should == nil
    end
  end

  describe "#product_or_first_variant_price" do
    before(:each) do
      @product = Factory(:product, :price => 5.00)
      size = Factory(:product_option)
      color = Factory(:product_option, :name => 'color')
      @large = Factory(:product_option_selection, :name => 'large', :product_option => size,
                       :price_adjustment => 2.00)
      @small = Factory(:product_option_selection, :name => 'small', :product_option => size)
      @red = Factory(:product_option_selection, :name => 'red', :product_option => color,
                       :price_adjustment => 1.00)
      @blue = Factory(:product_option_selection, :name => 'blue', :product_option => color)
      @product.product_options << [size, color]
    end

    it "should return the price of the first variant" do
      @product.product_or_first_variant_price.should == 8.00
    end
  end
end
