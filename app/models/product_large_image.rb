class ProductLargeImage < ActiveRecord::Base
    belongs_to :product_image, :foreign_key => 'parent_id'
               :product
    
    has_attachment :content_type => :image, 
                   :storage => :file_system
  
    validates_as_attachment
end