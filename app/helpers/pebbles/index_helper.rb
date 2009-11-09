module Pebbles::IndexHelper
  
  # displays empty message or category contents
  def featured_products(products)
    if products.length > 0
      count = 1
      cell = "<table>"
      cell += "<tr>"
      products.each do |product|
        # give-me an HTML abstraction/builder!
        cell += "<td>"
        if !product.product_images.empty?
          cell += link_to \
                  image_tag(product.product_images[0].public_filename(), \
                  :width => '146', :height => '141'), \
                  :controller => 'products', :action => 'show', :id => product.id
        end
        cell += "</td>"
			  cell += "</tr>" if (count % 2 == 0) 
				count += 1 
				cell += "<tr>" if (count % 2 == 0 < products.length)      
      end
      cell += "</table>"
      return cell
    end
  end
  
end
