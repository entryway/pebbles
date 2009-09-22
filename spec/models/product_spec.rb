require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../pebbles_factory'

describe Product do
  describe "#generate_variants" do
    before(:each) do
      @product = Factory(:product)
      size = Factory(:product_option)
      color = Factory(:product_option, :name => 'color') 
      size.product_option_selections << [Factory(:product_option_selection), 
                                         Factory(:product_option_selection, :name => 'small')]
      color.product_option_selections << [Factory(:product_option_selection, :name => 'red'), 
                                         Factory(:product_option_selection, :name => 'blue')]
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
      variant.sku.should == product.sku
    end
  end
  
end