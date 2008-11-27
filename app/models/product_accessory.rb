class ProductAccessory < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :accessory, :class_name => 'Product'
  
  def name
    accessory.name
  end
        
end