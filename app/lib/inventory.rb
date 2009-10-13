class Inventory
  
  def initialize
    @inventory_managed = inventory_managed?
  end
  
  def inventory_managed?
    GeneralConfiguration.instance.inventory_management?
  end
  
  ##
  # Validates a cart adding errors when cart_items exceed current inventory for product or variant
  #
  # @param [Cart] cart cart to validate 
  def validate_cart(cart)
    if @inventory_managed
      cart.cart_items.each do |cart_item|
        unless validate_cart_item(cart_item)
          cart.errors.clear
          if cart.product_total <= 0
            cart.errors.add_to_base("Our apologies, all items in your cart were no longer available.")
          else
            cart.errors.add_to_base("The quantity of certain items in your cart exceeded availability" +
                                " and were adjusted")
          end
        end
      end
    end
  end
  
  ##
  # Decreases the inventory for the products and or variants for items in an order
  #
  # @param [Order] order order to adjust inventory from order_items
  def decrease_order_inventory(order)
    if @inventory_managed
      order.order_items.each do |order_item|
        decrease_order_item_inventory(order_item)
      end
    end
  end

private
  
  ##
  # Validates a cart_item adjusting its quantity and adding an error if quantity exceeds inventory
  #
  # @param [CartItem] cart_item cart_item to validate
  # @return [<True, False>] whether the cart_item is valid
  def validate_cart_item(cart_item)
    item = cart_item.variant || cart_item.product
    if cart_item.quantity > item.inventory
      cart_item.quantity = item.inventory < 0 ? 0 : item.inventory
      cart_item.save!
      cart_item.errors.add(:quantity, "Your quantity exceeded inventory availability" +
                            " and was adjusted to #{item.inventory}")
      return false
    else
      return true
    end
  end
  
  ##
  # Decreases the inventory for the product or variant of an order_item
  #
  # @param [OrderItem] order_item the order_item to adjust inventory of for its product or variant.
  def decrease_order_item_inventory(order_item)
    item = order_item.variant || order_item.product
    item.inventory -= order_item.quantity
    item.save!
  end

end