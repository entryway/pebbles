module Pebbles::ProductsHelper
  
  def product_images(product)
    images = ''
    unless product.product_images.empty?
      product.product_images.each do |image|
        images += image_tag image.public_filename
      end
    end
    images
  end 
  
  def light_box(image_to_lightbox, image_to_link_from)
    tag = ''
    if image_to_lightbox.blank?
      # just show image
      tag += image_tag image_to_link_from
    else
      # lightbox link
      tag += link_to image_tag(image_to_link_from), image_to_lightbox,
             :rel => 'lightbox', :class => 'highlight'
    end
    tag
  end
  
  def bread_crumb(category)
    category.parent.name + " : " unless category.parent.nil?
  end
  
  # displays empty message or category contents
  def category_products(products)
    if products.length > 0
      count = 1
      cell = "<table cellpadding='0' cellspacing='0'' class='category_detail'>"
      cell += "<tr>"
      products.each do |product|
        # give-me an HTML abstraction/builder!
        cell += "<td>"
        if !product.product_images.empty?
          cell += link_to \
                  image_tag(product.product_images[0].public_filename(), \
                  :width => '146', :height => '141'), \
                  product_path(product.categories[0], product)
        end
        cell += "</td>"
			  cell += "</tr>" if (count % 4 == 0) 
				count += 1 
				cell += "<tr>" if (count % 4 == 0 < products.length)      
      end
      cell += "</table>"
      return cell
    end
  end
end
