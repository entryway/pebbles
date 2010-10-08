class CategoryIconHover < ActiveRecord::Base
  
  belongs_to :category_icon
    
  mount_uploader :filename, CategoryIconUploader

  validates_presence_of :filename
  
end