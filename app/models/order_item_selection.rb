class OrderItemSelection < ActiveRecord::Base
  belongs_to :order_item
  
  
  def self.from_product_option_selection(product_option_selection)
    ois = self.new
 
    ois.product_option_name = product_option_selection.product_option.name
    ois.option_selection_name = product_option_selection.name
    ois.price_adjustment = product_option_selection.price_adjustment
    ois.weight_adjustment = product_option_selection.weight_adjustment
    ois.sku_adjustment = product_option_selection.sku_adjustment   
    
    ois
  end
end
