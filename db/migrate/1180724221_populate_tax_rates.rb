class PopulateTaxRates < ActiveRecord::Migration
  def self.up
    TaxRate.create :rate => 2.5, :state => 'VA'
  end

  def self.down
  end
end
