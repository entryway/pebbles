class AddShippingCalculationMethodToGeneralConfiguration < ActiveRecord::Migration
  def self.up
    add_column :general_configurations, :shipping_calculation_method, :string
  end

  def self.down
    remove_column :general_configurations, :shipping_calculation_method
  end
end
