module Pebbles
  module Categories
    # all the categories for browsing
    # TODO: CACHE
    def categories
      Category.position_sorted
    end
  end
end
