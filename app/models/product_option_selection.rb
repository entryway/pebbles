class ProductOptionSelection < ActiveRecord::Base
  belongs_to :product_option
  has_many :variant_selections
  has_many :variants, :through => :variant_selections
  
  has_many :images, :class_name => 'ProductOptionSelectionImage'
  
end
