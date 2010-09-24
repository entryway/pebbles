class ProductImage < ActiveRecord::Base
  belongs_to :product
  
  has_one :product_image_thumbnail, :dependent => :destroy
  has_one :product_large_image, :dependent => :destroy
    
  mount_uploader :filename, ImageUploader
  
  validates_presence_of :filename
  
end