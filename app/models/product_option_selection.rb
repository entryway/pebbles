class ProductOptionSelection < ActiveRecord::Base
  belongs_to :product_option
  has_many :variant_selections
  has_many :variants, :through => :variant_selections, :dependent => :destroy
  
  has_many :images, :class_name => 'ProductOptionSelectionImage'
  
  after_create :generate_product_variants
  after_update :update_variants
  
  
  def product 
    self.product_option.products.first
  end 
  
  ##
  # generates all the selection variation variants for the selection's product
  def generate_product_variants
    # the associated product does not yet exist when the product option is first created
    # we do not want to generate variants in such a case since they will be created by the 
    # product_option_instance callback later
    unless product.nil?
      selection_id_arrays = [[self.id]]
      other_options = product.product_options.reject {|o| o == self.product_option}
      other_options.each do |o|
        selection_id_arrays << o.product_option_selection_ids
      end
      product.generate_variants_from_selection_ids(selection_id_arrays)
    end
  end
 
  ##
  # updates the weight and price of the selection's variants if the adjustments have changed
  def update_variants
    if price_adjustment_changed?  
      self.variants.each {|v| v.update_price}
    end
    if weight_adjustment_changed?
      self.variants.each {|v| v.update_weight}
    end
  end
  
end
