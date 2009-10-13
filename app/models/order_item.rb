class OrderItem < ActiveRecord::Base
  
  #acts_as_reportable 
  
  belongs_to :order 
  belongs_to :product
  belongs_to :variant
  
  # before_create do
  #   |order_item| order_item.check_inventory if GeneralConfiguration.instance.inventory_management 
  # end
  
  def self.from_cart_item(cart_item)
    oi = self.new
    
    oi.product_id = cart_item.product.id 
    oi.product_name = cart_item.product.name
    oi.price = cart_item.price
    oi.quantity = cart_item.quantity
    oi.weight = cart_item.product.weight
    oi.variant = cart_item.variant
    
    oi
  end
  
  
  def self.from_ebay_order(product, quantity)
    oi = self.new
    
    oi.product_id = product.id
    oi.product_name = product.name
    oi.price = product.price
    oi.quantity = quantity
    oi.weight = product.weight
    
    oi
  end
   
end
