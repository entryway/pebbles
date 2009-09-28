class ProductImage < ActiveRecord::Base
  belongs_to :product
  
  has_one :product_image_thumbnail
    
  mount_uploader :filename, ImageUploader
  
end