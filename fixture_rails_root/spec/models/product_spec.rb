require 'spec_helper'

describe Product do
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

    context '#non_primary_product_images' do
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
