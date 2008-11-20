class RenameProductOptionToOptionId < ActiveRecord::Migration
  def self.up
    drop_table :product_options
    drop_table :options
    drop_table :option_selections

    create_table :product_option_instances do |t|
      integer :product_id
      integer :product_option_id
    end
    add_index :product_option_instances, [:product_id]
    add_index :product_option_instances, [:product_option_id]
    
    create_table :product_options do |t|
      string  :name,  :limit => 50, :null => false
      integer :selection_type
      text    :description
    end
    
    create_table :product_option_selections do |t|
      string :name,                :limit => 50, :null => false
      decimal :price_adjustment,   :precision => 8, :scale => 2, :default => 0
      decimal :weight_adjustment,  :precision => 8, :scale => 2, :default => 0
      string  :sku_adjustment, :limit => 50
      integer :product_option_id 
    end
  end

  def self.down
  end
end
