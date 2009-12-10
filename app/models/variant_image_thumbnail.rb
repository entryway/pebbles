class VariantImageThumbnail < ActiveRecord::Base
  
    belongs_to :variant_image
    
    mount_uploader :filename, ImageUploader
    

end