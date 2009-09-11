class ProductOptionInstance < ActiveRecord::Base
  belongs_to :product_option  
  belongs_to :product
end
