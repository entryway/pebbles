module ProductVariant

  ##
  # Determine if the product has any variants.
  #
  # @returns[Boolean]
  def has_variants
    !self.variants.empty?
  end
  
  ##
  # Returns either the price of the product or for the first variant as ordered by product_options'
  # selections' default order
  #
  # @return [Float] price
  def product_or_first_variant_price
    if self.has_variants
      first_variant.price
    else
      price
    end
  end
  
  ##
  # Returns first variant as ordered by product_options' selections' default order
  #
  # @return [Variant] first variant
  def first_variant
    selection_ids = self.product_options.map { |o| o.product_option_selections.first.id }
    find_variant_by_selection_ids(selection_ids)
  end
    
  ##
  # Returns variant which associates with the Array of product_option_selection ids
  #
  # @param [Array] selection_ids ids for the selection_ids to match
  # @return [Variant] matching variant
  def find_variant_by_selection_ids(selection_ids)
    self.variants.detect{ |v| v.product_option_selection_ids.sort == selection_ids.sort } if selection_ids
  end
        

  ##
  # Regenerates all the variants for the product
  def generate_variants
    self.variants.clear
    selection_id_arrays = Array.new
    product_options = self.product_options
    product_options.each do |po|
      selection_id_arrays << po.product_option_selection_ids
    end
    generate_variants_from_selection_ids(selection_id_arrays)
  end
  
  ##
  # Generates variants from the array list of selection ids
  #
  # @param[Array] selection_id_arrays an Array of selection_id arrays for each product_option
  def generate_variants_from_selection_ids(selection_id_arrays)
    variant_cartesian_product = cartprod(*selection_id_arrays)
    variant_cartesian_product.each do |variant_selection_ids|
      generate_variant(variant_selection_ids)
    end
  end
  
  ##
  # Generates an variant and the relations to its product_option_selections
  #
  # @param[Array] selection_ids an Array of selection ids for the variant to associate
  def generate_variant(selection_ids)
    selections = ProductOptionSelection.find(selection_ids)
    variant_price = self.price + selections.inject(0){|sum, s| sum + s.price_adjustment }
    variant_weight = self.weight + selections.inject(0){|sum, s| sum + s.weight_adjustment }
    variant = self.variants.create(:price => variant_price, :weight => variant_weight, 
                                   :inventory => 0, :sku => self.sku)
    selections.each do |s|
      s.variants << variant
    end
  end

private 
  
  ##
  # Generates an array of array objects that are a cartesian product of a list of array objects
  # e.g. [1,2], [3,4], [5,6]=> [[1,3,5],[1,3,6],[1,4,5],[1,4,6],[2,3,5],[2,3,6],[2,4,5],[2,4,6]]
  # 
  # @param [Array] args a variable amount of Arrays for the cartesian product
  def cartprod(*args)
    result = [[]]
    while [] != args
      t, result = result, []
      b, *args = args
      t.each do |a|
        b.each do |n|
          result << a + [n]
        end
      end
    end
    result
  end

end
