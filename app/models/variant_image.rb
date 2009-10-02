class VariantImage < ActiveRecord::Base
  has_many :variants, :dependent => :nullify
  
  has_one :variant_image_thumbnail, :dependent => :destroy
  has_one :variant_large_image, :dependent => :destroy

  mount_uploader :filename, ImageUploader
  
  def product
    variants.first.product
  end
  
end
