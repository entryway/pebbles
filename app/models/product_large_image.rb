class ProductLargeImage < ActiveRecord::Base
  belongs_to :product_image

  mount_uploader :filename, ImageUploader

  validates_presence_of :filename

  def product
    product_image.product
  end

end
