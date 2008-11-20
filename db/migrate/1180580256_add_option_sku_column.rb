class AddOptionSkuColumn < ActiveRecord::Migration
  def self.up
    add_column :option_selections, :sku, :string
  end

  def self.down
    remove_column :option_selections, :sku    
  end
end
