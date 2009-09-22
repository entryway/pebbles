class ProductOptionSelection < ActiveRecord::Base
  belongs_to :product_option
  has_many :variant_selections
  has_many :variants, :through => :variant_selections
  
  has_many :images, :class_name => 'ProductOptionSelectionImage'
  
  after_create :generate_product_variants
  after_update :update_variants
  
  def product 
    self.product_option.products.first
  end 
  
  def generate_product_variants
    unless product.nil?
      selection_id_arrays = [[self.id]]
      other_options = product.product_options.reject {|o| o == self.product_option}
      other_options.each do |o|
        selection_id_arrays << o.product_option_selection_ids
      end
      product.generate_variants_from_selection_ids(selection_id_arrays)
    end
  end
 
  def update_variants
    if price_adjustment_changed?  
      self.variants.each {|v| v.update_price}
    end
    if weight_adjustment_changed?
      self.variants.each {|v| v.update_weight}
    end
  end
  
end
