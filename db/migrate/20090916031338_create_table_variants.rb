class CreateTableVariants < ActiveRecord::Migration
  def self.up
    create_table :variants do |t| 
      t.integer :product_id, :inventory
      t.decimal :weight, :price
      t.boolean :out_of_stock, :default => false
      t.string :sku
      t.timestamps
    end
  end

  def self.down
    drop_table :variants
  end
end
