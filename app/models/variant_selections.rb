class VariantSelection < ActiveRecord::Base
  belongs_to :production_option_selection
  belongs_to :variant
end