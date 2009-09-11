class CategoryImage < ActiveRecord::Base
    belongs_to :category
    
    has_attachment :content_type => :image, 
                   :storage => :file_system

    validates_as_attachment
  
end