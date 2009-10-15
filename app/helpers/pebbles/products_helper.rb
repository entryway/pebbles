module Pebbles::ProductsHelper

  ##
  # Add a image magnifier if the large image exists.
  #
  # @param[String] image The name of the image to use as a magnifier.
  # @param[String] image_url The url of the image being magnifed. 
  # @param[Hash] options Additonal options, class, etc. 
  def image_magnify(image, image_url, options={}) 
    if image_url.present?
      image_tag image, options
    end
  end

  ##
  # Creates a light boxed image link if the image to lightbox exists. 
  #
  # @param[String] image_url The image url to link to a lightbox. 
  # @param[String] light_boxed_image The image url of the image to lightbox. 
  # @param[Hash] options Options to pass to the image tag. 
  def light_box(image_url, light_boxed_image, options={})
    if light_boxed_image.blank?
      # just show image
      image_tag image_url, options
    else
      # lightbox link
      link_to image_tag(image_url, options), light_boxed_image,
              :rel => 'lightbox', :class => 'highlight'
    end
  end

  def disable(category, product)
    'disabled="disabled"' if product.category_ids.include?(category.id)
  end
  
end
