class CreateStore < ActiveRecord::Migration
  def self.up
     create_table :stores do |table|
      string :address, :limit => 255 
      string :city, :limit => 50 
      string :state, :limit => 50 
      string :zip, :limit => 10
      string :storename, :limit => 255 
      string :hours, :limit => 50 
      string :url, :limit => 50
      string :phone, :limit => 50 
      string :country, :limit => 50
      float :lat 
      float :lng

      timestamp!
     end
  end

  def self.down
    #drop_table :stores
  end
end
