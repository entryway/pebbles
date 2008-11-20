class CreatePromoCodes < ActiveRecord::Migration
  def self.up
    create_table :promo_codes do
      string  :name, :limit => 150, :null => false  
      string  :code, :limit => 30, :null => false, :default => ''
      decimal :dollar_discount, :precision => 8, :scale => 2, :default => 0.0
      decimal :percent_discount, :precision => 8, :scale => 2, :default => 0.0  
      boolean :free_shipping, :default => false
      text    :free_shipping_note, :default => ''
      boolean :first_time_only, :default => false
      timestamps!
    end
      
    add_column :carts, :promo_code, :string, :limit => 30, :default => ''
    add_column :carts, :promo_discount, :decimal, :precision => 8, 
                                         :scale => 2, :default => 0.0
    add_column :carts, :free_shipping, :boolean, :default => 'f'
    
    add_column :orders, :promo_code, :string, :limit => 30, :default => ''
    add_column :orders, :promo_discount, :decimal, :precision => 8, 
                                         :scale => 2, :default => 0.0
    add_column :orders, :free_shipping, :boolean, :default => 'f'
  end

  def self.down
    drop_table coupons
    remove_column :orders, :promo_discout
    remove_column :orders, :promo_code
  end
end