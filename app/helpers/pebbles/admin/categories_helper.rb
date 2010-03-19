module Pebbles::Admin::CategoriesHelper
  def dash_tree(item)
    return "<span class=\"category-tree\">&mdash;</span>" * item.level
  end
  
  safe_helper :dash_tree

  def tree_padding(item)
    return "#{item.level * 20}px"
  end
end
