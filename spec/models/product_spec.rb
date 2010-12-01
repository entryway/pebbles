require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  context "validations" do
    context "require weight" do
      context "when shipping by weight" do
        it "validates presence of weight" do
          config = mock("foo", :shipping_calculation_method => 'weight')
          GeneralConfiguration.should_receive(:instance).and_return(config)
          p = Product.new(:weight => nil)
          p.valid?
          p.errors.on(:weight).should_not be nil
        end
      end
      context "when not shipping by weight" do
        it "does not validate presence of weight" do
          p = Product.new(:weight => nil)
          p.valid?
          p.errors.on(:weight).should be nil
        end
      end
    end
  end

  context "named scopes" do
    describe "non_featured" do
      before do
        @non_featured_product = Factory(:product, :is_featured => false)
        @featured_product = Factory(:product, :is_featured => true)
      end

      it "returns products that are not featured" do
        Product.non_featured.should ==  [@non_featured_product]
      end
    end
  end

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

  context 'primary product images' do
    before do
      @product = Factory(:product)
      @primary_product_image = Factory(:product_image, :primary => true)
      @product_image = Factory(:product_image)
    end

    context '#primary_product_image' do
      context 'when a product has a primary image' do
        it 'returns the primary product image' do
          @product.product_images << @primary_product_image
          @product.primary_product_image.should == @primary_product_image
        end
      end

      context 'when a product has product images but none are primary' do
        it 'returns the first product image' do
          @product.product_images << @product_image
          @product.primary_product_image.should == @product_image
        end
      end

      context 'when a product has no product images' do
        it 'returns nil' do
          @product.primary_product_image.should == nil
        end
      end
    end

    describe '#non_primary_product_images' do
      context 'when product has a primary image' do
        it 'returns an empty array' do
          @product.product_images << @primary_product_image
          @product.non_primary_product_images.should == []
        end
      end

      context 'when a product has multiple product images' do
        it 'returns an array of non primary product images' do
          @product.product_images << @product_image
          another_product_image = Factory(:product_image)
          @product.product_images << another_product_image
          @product.non_primary_product_images.should == [another_product_image]
        end
      end

      context 'when a product has no product images' do
        it 'returns an empty array' do
          @product.non_primary_product_images.should == []
        end
      end
    end
  end
end
