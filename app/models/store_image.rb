class StoreImage < ActiveRecord::Base
    belongs_to :store
    
    has_attachment :content_type => :image, 
                   :storage => :file_system
                 
    validates_as_attachment
  
end