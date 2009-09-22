module Pebbles::StoresHelper
  
  def set_decimal(number)
    number = sprintf("%.2f", number)
  end
end
