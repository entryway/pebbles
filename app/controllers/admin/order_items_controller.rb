module Admin

  class OrderItemsController < ApplicationController
    layout "admin"
    require_role "admin"
    
   def update
     order_item = OrderItem.find(params[:id])
     quantity = params[:quantity].to_i
     unless quantity < 0
       if order_item.quantity != quantity
         order_item.quantity = quantity
         order_item.save!
       end
     end
     @order = order_item.order    
     @order.calculate_order_costs
     @order.save!
   end
   
   def destroy
     order_item = OrderItem.find(params[:id])
     @order = order_item.order
     order_item.destroy
     @order.calculate_order_costs
     @order.save!
  end
end
  
  
    
end