class ProductImage < ActiveRecord::Base
  belongs_to :product
  
  has_one :product_image_thumbnail
  has_one :product_large_image
    
  mount_uploader :filename, ImageUploader
  
end