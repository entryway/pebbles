class ProductOptionSelection < ActiveRecord::Base
  belongs_to :product_option
  
  has_many :images, :class_name => 'ProductOptionSelectionImage'
  
end
