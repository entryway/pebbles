class VariantImage < ActiveRecord::Base
  has_many :variants, :dependent => :nullify

  has_one :variant_image_thumbnail, :dependent => :destroy
  has_one :variant_large_image, :dependent => :destroy

  mount_uploader :filename, ImageUploader

  def product
    variants.first.product
  end

  ##
  # The url for the variant image.
  #
  # @return [String] The image url for the variant or an empty string if one doesn't exist.
  def image_url
    self.filename.url
  end

  ##
  # The url for the thumbnail for the variant image.
  #
  # @return[String] The thumbnail url for the variant or an empty string if one doesn't exist.
  def thumbnail_url
    return '' if self.variant_image_thumbnail.blank?
    self.variant_image_thumbnail.filename.url
  end

  ##
  # The url for the variant large image.
  #
  # @return [String] The url of the large variant or empty string if one doesn't exist.
  def large_image_url
    return '' if self.variant_large_image.blank?
    self.variant_large_image.filename.url
  end

end
