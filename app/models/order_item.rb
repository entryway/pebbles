class OrderItem < ActiveRecord::Base
  
  #acts_as_reportable 
  
  belongs_to :order 
  belongs_to :product
  
  has_many :order_item_selections
    
  def self.from_cart_item(cart_item)
    oi = self.new
    
    oi.product_id = cart_item.product.id 
    oi.product_name = cart_item.product.name
    oi.price = cart_item.price
    oi.quantity = cart_item.quantity
    oi.weight = cart_item.product.weight
    
    # FAUX PRODUCT MODULE
    #oi.product_name = cart_item.faux_product ? "Power Supply for " + cart_item.faux_product.name : cart_item.product.subname
    
    # TODO: DROP-SHIP Module, commented out to save cycles ~gwp
    #vendor = Vendor.find(cart_item.product.vendor_id)
    #oi.drop_ship = vendor.drop_ship
    #oi.drop_shipping_cost = vendor.shipping
    
    # PRODUCT OPTION Module
    oi.adjusted_price = cart_item.product.price
    oi.adjusted_weight = cart_item.product.weight
    # copy selections
    cart_item.option_selections.each do |item_selection|  
      ois = OrderItemSelection.from_product_option_selection(item_selection.product_option_selection)
 
      # adjust the order item's price and weight according to the selected option
      oi.adjusted_price += ois.price_adjustment
      oi.adjusted_weight += ois.weight_adjustment        
         
      oi.order_item_selections << ois
    end
    
    if cart_item.product_accessory
      oi.adjusted_price = cart_item.product_accessory.price
    end
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
