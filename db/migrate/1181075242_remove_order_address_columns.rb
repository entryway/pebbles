class RemoveOrderAddressColumns < ActiveRecord::Migration
  def self.up

    #shipping address
    remove_column :orders, :ship_to_full_name
    remove_column :orders, :ship_to_address_1
    remove_column :orders, :ship_to_address_2
    remove_column :orders, :ship_to_city
    remove_column :orders, :ship_to_state
    remove_column :orders, :ship_to_postal_code
    
    #billing address
    remove_column :orders, :bill_to_address_1
    remove_column :orders, :bill_to_address_2
    remove_column :orders, :bill_to_city
    remove_column :orders, :bill_to_state
    remove_column :orders, :bill_to_postal_code

    remove_column  :orders,  :shipping_same_as_billing

  end

  def self.down
    
    #shipping address
    add_column :orders, :ship_to_full_name,     :string, :limit => 50
    add_column :orders, :ship_to_address_1,     :string, :limit => 50
    add_column :orders, :ship_to_address_2,     :string, :limit => 50
    add_column :orders, :ship_to_city,          :string, :limit => 50
    add_column :orders, :ship_to_state,         :string, :limit => 2
    add_column :orders, :ship_to_postal_code,   :string, :limit => 10
    
    #billing address
    add_column :orders, :bill_to_address_1,     :string, :limit => 50
    add_column :orders, :bill_to_address_2,     :string, :limit => 50
    add_column :orders, :bill_to_city,          :string, :limit => 50
    add_column :orders, :bill_to_state,         :string, :limit => 2
    add_column :orders, :bill_to_postal_code,   :string, :limit => 10

    add_column  :orders,  :shipping_same_as_billing,  :boolean
  end
end
