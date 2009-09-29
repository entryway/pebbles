class ProductOptionInstance < ActiveRecord::Base
  belongs_to :product_option  
  belongs_to :product
  
  after_create :regenerate_product_variants
  after_destroy :regenerate_product_variants
  
  
  def regenerate_product_variants
    self.product.generate_variants
  end
  
end
