class ProductOptionSelectionImage < ActiveRecord::Base
    belongs_to :product_option_selection
    
    has_attachment :content_type => :image, 
                   :storage => :file_system

    validates_as_attachment
  
end