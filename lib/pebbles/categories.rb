module Pebbles
  module Categories
    # all the categories for browsing
    # TODO: CACHE
    helper_method :categories
    def categories
      Category.position_sorted
    end
  end
end
