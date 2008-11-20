class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      #contact information
      t.column  :full_name,             :string, :limit => 50
      t.column  :email,                 :string, :limit => 100
      t.column  :phone_number,          :string, :limit => 15
      
      #shipping address
      t.column  :ship_to_full_name,     :string, :limit => 50
      t.column  :ship_to_address_1,     :string, :limit => 50
      t.column  :ship_to_address_2,     :string, :limit => 50
      t.column  :ship_to_city,          :string, :limit => 50
      t.column  :ship_to_state,         :string, :limit => 2
      t.column  :ship_to_postal_code,   :string, :limit => 10
      t.column  :ship_to_country,       :string, :limit => 50

      #payment information
      t.column  :card_name,             :string, :limit => 50
      t.column  :card_number,           :string, :limit => 20
      t.column  :card_type,             :string, :limit => 20
      t.column  :card_security_code,    :string, :limit => 5
      t.column  :card_expiration_month, :string, :limit => 2
      t.column  :card_expiration_year,  :string, :limit => 2
      
      #billing address
      t.column  :bill_to_address_1,     :string, :limit => 50
      t.column  :bill_to_address_2,     :string, :limit => 50
      t.column  :bill_to_city,          :string, :limit => 50
      t.column  :bill_to_state,         :string, :limit => 2
      t.column  :bill_to_postal_code,   :string, :limit => 10
      t.column  :bill_to_country,       :string, :limit => 50
            
    end    
  end

  def self.down
    drop_table :orders
  end
end
