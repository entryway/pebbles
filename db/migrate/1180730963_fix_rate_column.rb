class FixRateColumn < ActiveRecord::Migration
  def self.up
    TaxRate.delete_all

    remove_column :tax_rates,   :rate
    add_column :tax_rates,      :rate,   :decimal, :precision => 8, :scale => 5, :default => 0.0
  end

  def self.down
  end
end
