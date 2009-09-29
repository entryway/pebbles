class ProductLargeImage < ActiveRecord::Base
  belongs_to :product_image
    
  mount_uploader :filename, ImageUploader
  
end