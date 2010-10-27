class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_one :product_image_thumbnail, :dependent => :destroy
  has_one :product_large_image, :dependent => :destroy

  mount_uploader :filename, ImageUploader

  validates_presence_of :filename

  named_scope :sort_by_primary, :order => 'product_images.primary DESC'
  named_scope :non_primary, :conditions => "product_images.primary IS NOT TRUE"

  named_scope :primary, :conditions => {:primary => true}

  before_save :ensure_one_primary_product_image_per_product

  private
  def ensure_one_primary_product_image_per_product
    product.product_images.update_all(:primary => false) if product && primary?
  end
end
