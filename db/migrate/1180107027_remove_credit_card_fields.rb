class RemoveCreditCardFields < ActiveRecord::Migration
  def self.up
    remove_column  :orders,   :card_name
    remove_column  :orders,   :card_number
    remove_column  :orders,   :card_type
    remove_column  :orders,   :card_security_code
    remove_column  :orders,   :card_expiration_month
    remove_column  :orders,   :card_expiration_year
  end

  def self.down
    add_column :orders,  :card_name,             :string, :limit => 50
    add_column :orders,  :card_number,           :string, :limit => 20
    add_column :orders,  :card_type,             :string, :limit => 20
    add_column :orders,  :card_security_code,    :string, :limit => 5
    add_column :orders,  :card_expiration_month, :string, :limit => 2
    add_column :orders,  :card_expiration_year,  :string, :limit => 2
  end
end
