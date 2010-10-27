class GeneralConfiguration < ActiveRecord::Base
  acts_as_singleton

  def self.shipping_calculated_by_weight?
    self.instance.shipping_calculation_method == 'weight'
  end

end
