class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t| 
      t.column :product_id, :integer 
      t.column :order_id, :integer 

      t.column :price_as_cents, :integer
      t.column :adjusted_price_as_cents, :integer
      
      t.column :quantity, :integer 
      t.column :created_at, :timestamp 
      t.column :updated_at, :timestamp 
    end 
  end 
  
  def self.down 
    drop_table :order_items 
  end
end
