module Pebbles::VariantsHelper

  ##
  # A link to the variant thumbnail, resizes the regular image if one doesn't exist.
  #
  # @param[String] VariantImage The variant image to create a thumbnail link for.
  def variant_thumbnail(image)
    thumbnail = image.variant_image_thumbnail || image
    thumbnail.filename.url
  end

end
