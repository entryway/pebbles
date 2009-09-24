class Product < ActiveRecord::Base
  belongs_to :vendor
  has_many :product_images 
  has_many :product_large_images
  has_many :quantity_discounts 
  
  has_and_belongs_to_many  :categories
  
  has_many :out_of_stock_options, :dependent => :destroy
  
  has_many :order_items
  has_many :orders, :through => :order_items
   
  has_many :product_option_instances, :dependent => :destroy
  has_many :product_options, :through => :product_option_instances 

  has_many :variants, :dependent => :destroy
  has_many :product_accessories, :order => 'id'
  has_many :accessories, :through => :product_accessories
  
  validates_presence_of :name
  validates_presence_of :sku
  validates_uniqueness_of :sku

  after_update :save_quantity_discounts 
  
  named_scope :featured, :order => :name,
                :conditions => { :is_featured => true,
                                 :available => true }
              
  named_scope :available, :order => :name,
                :conditions => { :available => true }
  
  accepts_nested_attributes_for :variants
  accepts_nested_attributes_for :product_options, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['name'].blank? }
  
  def product_image(thumb=false)
    if thumb
      unless product_images.empty? || product_images[0].thumbnails.empty?
        return product_images[0].thumbnails[0].public_filename 
      end
    else
      return product_images[0].public_filename unless product_images.empty?
    end
    ''
  end
  
  def product_large_image
    return product_large_images[0].public_filename unless product_large_images.empty?
    ''
  end
  
  # return the active product category
  def category
    # only returns first category currently
    if self.categories.empty?
      1
    else
      self.categories[0] unless self.categories.empty?
    end
  end
  

  
  # are these particlar option selections out of stock?
  def out_of_stock?(out_of_stock_option_selections)
    OutOfStockOption.out_of_stock?(self.id, out_of_stock_option_selections)
  end
  
  # update the quantity discounts dependent on attributes
  def quantity_discount_attributes=(quantity_discount_attributes)
    quantity_discount_attributes.each do |attributes|
      if attributes[:id].blank?
        quantity_discounts.build(attributes)
      else
        quantity_discount = quantity_discounts.detect { |q| q.id == attributes[:id].to_i }
        quantity_discount.attributes = attributes
      end
    end
  end

  
  def save_quantity_discounts
    quantity_discounts.each do |qd|
      qd.save(false)
    end
  end
  
  # gets the price adjustment for the product when an accessory of a given product
  def accessory_price(product)
    product_accessory = product.product_accessories.find(:first, :conditions => {:accessory_id => self.id})
    price = self.price + (product_accessory.price_adjustment || 0)
  end
  
  #get the shipping type of the product or vendor shipping type if defaulting
  def determined_shipping_type
    if self.shipping_type == ShippingType::DEFAULT_SHIPPING
      return self.vendor.shipping_type
    else
      return shipping_type
    end
  end
  
  def specification
    { :weight => weight, :dimensions => [length || 0 , width || 0, height || 0 ] }
  end
  
  def has_variants
    !self.variants.empty?
  end
  
  ##
  # returns either the price of the product or for the first variant as ordered by product_options'
  # selections' default order
  # @return [Float] price
  def product_or_first_variant_price
    if self.has_variants
      first_variant.price
    else
      price
    end
  end
  
  ##
  # returns first variant as ordered by product_options' selections' default order
  # @return [Variant] first variant
  def first_variant
    selection_ids = self.product_options.map { |o| o.product_option_selections.first.id }
    find_variant_by_selection_ids(selection_ids)
  end
    
  ##
  # returns variant which associates with the Array of product_option_selection ids
  #
  # @param [Array] selection_ids ids for the selection_ids to match
  # @return [Variant] matching variant
  def find_variant_by_selection_ids(selection_ids)
    self.variants.detect{ |v| v.product_option_selection_ids.sort == selection_ids.sort }
  end
        

  ##
  # regenerates all the variants for the product
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
  # generates variants from the array list of selection ids
  #
  # @param[Array] selection_id_arrays an Array of selection_id arrays for each product_option
  def generate_variants_from_selection_ids(selection_id_arrays)
    variant_cartesian_product = cartprod(*selection_id_arrays)
    variant_cartesian_product.each do |variant_selection_ids|
      generate_variant(variant_selection_ids)
    end
  end
  
  ##
  # generates an variant and the relations to its product_option_selections
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
  
    
  
  protected
  
  def validate
    errors.add(:name, "needs to be present.") if name.nil?
    errors.add(:sku, "needs to be present.") if sku.nil?
  end
  
private 
  
  ##
  # generates an array of array objects that are a cartesian product of a list of array objects
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