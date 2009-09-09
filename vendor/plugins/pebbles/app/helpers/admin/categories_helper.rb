module Admin::CategoriesHelper
  def dash_tree(item)
    return "<span class=\"category-tree\">&mdash;</span>" * item.level
  end

  def tree_padding(item)
    return "#{item.level * 20}px"
  end
end
