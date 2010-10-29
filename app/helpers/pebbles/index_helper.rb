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
                  image_tag(product.product_images[0].filename.url, \
                  :width => '146', :height => '141'), \
                  category_product_path(product.category, product)
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
