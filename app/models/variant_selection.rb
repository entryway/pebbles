class VariantSelection < ActiveRecord::Base
  belongs_to :product_option_selection
  belongs_to :variant
end