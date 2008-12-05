class CreateSupplierId < ActiveRecord::Migration
  def self.up
    add_column :products, :supplier_id, :integer 
  end

  def self.down
    remove_column :products, :supplier_id
  end
end
