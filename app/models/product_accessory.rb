class ProductAccessory < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :accessory, :class_name => 'Product'
  has_many :cart_items
  
  def name
    accessory.name
  end
  
  def price
    accessory.accessory_price(product)
  end
        
end