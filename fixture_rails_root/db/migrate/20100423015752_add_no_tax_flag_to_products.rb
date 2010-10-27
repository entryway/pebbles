class AddNoTaxFlagToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :no_tax, :boolean, :default => false
  end

  def self.down
  end
end
