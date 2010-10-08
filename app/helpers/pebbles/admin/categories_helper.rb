module Pebbles::Admin::CategoriesHelper
  def dash_tree(item)
    result = "<span class=\"category-tree\">&mdash;</span>" * item.level
    result.html_safe!
  end

  def tree_padding(item)
    return "#{item.level * 20}px"
  end
end
