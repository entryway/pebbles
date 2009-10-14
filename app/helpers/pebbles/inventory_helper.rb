module Pebbles::InventoryHelper

  def validate_inventory?
    if GeneralConfiguration.instance.inventory_management?
      "inventory"
    end
  end
    
  
  def inventory_management_hidden_field(inventory)
    if GeneralConfiguration.instance.inventory_management?
      hidden_field_tag 'inventory', inventory, :id => 'inventory'
    end
  end

end
