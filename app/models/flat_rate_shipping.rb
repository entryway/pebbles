class FlatRateShipping < ActiveRecord::Base

  belongs_to :shipping_method
  has_many :fulfillment_codes

  default_scope :order => 'order_total_low, weight_low'
  named_scope :ordered_by_total_ranges, :order => 'order_total_low'

  named_scope :ordered_by_weight_ranges, lambda {|weight|{:conditions => ["weight_low <= #{weight}"]}}

end
