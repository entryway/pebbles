class ProductImage < ActiveRecord::Base
    belongs_to :product
    
    has_attachment :content_type => :image, 
                   :storage => :file_system,
                   :thumbnail_class => ProductImageThumbnail

    validates_as_attachment
  
end