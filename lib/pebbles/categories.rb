module Pebbles
  module Categories

    def self.included(base)
      base.class_eval do
        helper_method :categories
      end
    end
    # all the categories for browsing
    # TODO: CACHE
    def categories
      Category.position_sorted
    end
  end
end
