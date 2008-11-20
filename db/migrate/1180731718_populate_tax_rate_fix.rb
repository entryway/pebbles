class PopulateTaxRateFix < ActiveRecord::Migration
  def self.up
    TaxRate.delete_all
    TaxRate.create :rate => 0.0250, :state => 'VA'
  end

  def self.down
  end
end
