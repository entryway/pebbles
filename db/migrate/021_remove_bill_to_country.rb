class RemoveBillToCountry < ActiveRecord::Migration
  def self.up
    remove_column  :orders,  :bill_to_country
  end

  def self.down
    add_column :orders, :bill_to_country, :string, :limit => 50
  end
end
