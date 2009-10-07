module Pebbles::CategoryHelper
  def category_link(category)
    if category.leaf?
      category_products_path(category)
    else
      category_path(category)
    end
  end

  def category_image(category)
    image_tag(category.category_images[0].filename.url, :alt => 'icon')
  end

end

