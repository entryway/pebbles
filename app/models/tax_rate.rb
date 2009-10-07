class TaxRate < ActiveRecord::Base
  
  def self.calculate_tax(state, sub_total)
    t = 0
    taxrate = TaxRate.find_by_state(state)
    unless taxrate.nil?
      t = (taxrate.rate * sub_total)
    end
    t
  end
end
