class CreateTaxRates < ActiveRecord::Migration
  def self.up
    create_table :tax_rates do |t|
      t.column :rate,           :decimal, :precision => 8, :scale => 2, :default => 0.0
      t.column :state,          :string,    :limit => 2
      t.column :postal_code,    :string,    :limit => 10
    end
  end

  def self.down
    drop_table :tax_rates
  end
end
