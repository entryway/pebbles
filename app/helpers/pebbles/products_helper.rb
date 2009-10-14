module Pebbles::ProductsHelper
  
  def validate_inventory?
    if GeneralConfiguration.instance.inventory_management?
      "inventory"
    end
  end
    
  
  def inventory_management_hidden_field(inventory)
    if GeneralConfiguration.instance.inventory_management?
      hidden_field_tag 'inventory', inventory, :id => 'inventory'
    end
  end
  
  def find_or_create_thumbnail(image)
    thumbnail = image.variant_image_thumbnail || image
    link_to (image_tag image.filename.url, :height => 30, :class => 'thumbnail', :id => image.id), 
             variant_image_path(image)
  end
  
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
  # @param[String] image The image url to link to a lightbox. 
  # @param[String] light_boxed_image The image url of the image to lightbox. 
  def light_box(image, light_boxed_image)
    if light_boxed_image.blank?
      # just show image
      image_tag image
    else
      # lightbox link
      link_to image_tag(image), light_boxed_image,
              :rel => 'lightbox', :class => 'highlight'
    end
  end
  
  def bread_crumb(category)
    category.parent.name + " : " unless category.parent.nil?
  end
  
end
