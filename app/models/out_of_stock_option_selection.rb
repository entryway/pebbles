class OutOfStockOptionSelection < ActiveRecord::Base
  belongs_to :out_of_stock_option
  belongs_to :product_option_selection
end