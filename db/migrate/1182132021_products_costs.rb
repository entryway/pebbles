class ProductsCosts < ActiveRecord::Migration
  def self.up
    remove_column :products, :price_as_cents
    add_column :products, :price,     :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :products, :price
    add_column :products, :price_as_cents,   :integer, :default => 0
  end
end
