class ProductOptionInstance < ActiveRecord::Base
  belongs_to :product_option  
  belongs_to :product
  
  after_create :destroy_product_variants
  
  
  def destroy_product_variants
    self.product.generate_variants
  end
  
end
