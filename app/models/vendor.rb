class Vendor < ActiveRecord::Base
  
    has_many  :products
    has_one :address
    
end
