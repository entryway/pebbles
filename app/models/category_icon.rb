class CategoryIcon < ActiveRecord::Base
  
  belongs_to :category
    
  mount_uploader :filename, ImageUploader
  
end