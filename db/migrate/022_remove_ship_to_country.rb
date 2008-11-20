class RemoveShipToCountry < ActiveRecord::Migration
  def self.up
    remove_column  :orders,  :ship_to_country
  end

  def self.down
    add_column :orders, :ship_to_country, :string, :limit => 50
  end
end
