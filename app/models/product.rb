class Product < ActiveRecord::Base
  acts_as_reportable

  include ProductVariant

  belongs_to :vendor
  has_many :product_images, :dependent => :destroy

  has_many :quantity_discounts

  has_and_belongs_to_many  :categories

  has_many :out_of_stock_options, :dependent => :destroy

  has_many :order_items
  has_many :orders, :through => :order_items

  has_many :product_option_instances, :dependent => :destroy
  has_many :product_options, :through => :product_option_instances

  has_many :variants, :dependent => :destroy
  has_many :variant_images, :through => :variants, :uniq => true
  has_many :product_accessories, :order => 'id'
  has_many :accessories, :through => :product_accessories

  validates_presence_of :name
  validates_presence_of :sku
  validates_uniqueness_of :sku
  validates_numericality_of :inventory, :only_integer => true, :greater_than_or_equal_to => 0

  after_update :save_quantity_discounts

  named_scope :featured, :order => :name,
                :conditions => { :is_featured => true,
                                 :available => true }
  named_scope :non_featured, :order => :name, :conditions => "is_featured IS NOT true and available IS true"
  named_scope :available, :order => :name,
                :conditions => { :available => true }

  accepts_nested_attributes_for :variants
  accepts_nested_attributes_for :product_options, :allow_destroy => true,
                                :reject_if => proc{ |attributes| attributes['name'].blank? }

  has_friendly_id :name, :use_slug => true

  #
  # TODO: this should be moved to admin product_helper
  def created_product_options
    product_options.select {|o| !o.new_record? }
  end

  def primary_product_image
    product_images.primary.first || product_images.first
  end

  def non_primary_product_images
    product_images.non_primary - [primary_product_image]
  end

  ##
  # Grab the first available product image.
  #
  # @return [String] The image url for the product or an empty string if one doesn't exist.
  def image_url
    return '' if product_images.empty?
    product_images[0].filename.url
  end

  ##
  # Grab the first available thumbnail for the product image.
  #
  # @return[String] The thumbnail url for the product or an empty string if one doesn't exist.
  def thumbnail_url
    return '' if self.image_url.empty? || self.product_images[0].product_image_thumbnail.blank?
    self.product_images[0].product_image_thumbnail.filename.url
  end

  ##
  # Grab the first available product large image
  #
  # @return [String] The url of the large product or empty string if one doesn't exist.
  def large_image_url
    return '' if self.image_url.empty? || self.product_images[0].product_large_image.blank?
    self.product_images[0].product_large_image.filename.url
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
    product_accessory = product.product_accessories.find(:first,
                                                         :conditions =>
                                                          { :accessory_id => self.id } )
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

protected

  def validate
    errors.add(:name, "needs to be present.") if name.nil?
    errors.add(:sku, "needs to be present.") if sku.nil?
  end

end
