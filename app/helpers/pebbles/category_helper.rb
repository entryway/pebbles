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

  def category_li(category)
    if category.leaf?
      "<li class='leaf category_item' id='#{category.id}'>"
    else
      "<li class='branch category_item' id='#{category.id}'>"
    end
  end

end

