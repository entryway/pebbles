class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :variant_selections
  has_many :product_option_selections, :through => :variant_selections, :order => 'product_option_id'
end
