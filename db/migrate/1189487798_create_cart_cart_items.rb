class CreateCartCartItems < ActiveRecord::Migration
  def self.up
    create_table :carts do
      string :name, :limit => 40
    
      timestamps!
    end
    
    create_table :cart_items do
        foreign_key :product
        foreign_key :cart
        
        integer :quantity
        
        timestamps!
    end
  end

  def self.down
    drop_table :carts
    drop_table :carts_items
  end
end
