module Pebbles::CategoryHelper
  def category_link(category)
    if category.leaf?
      category_products_path(category)
    else
      category_path(category)
    end
  end

  def category_image(category)
    image_tag("icon-#{category.name.split.first.downcase}.gif", :alt => 'icon')
  end

end

