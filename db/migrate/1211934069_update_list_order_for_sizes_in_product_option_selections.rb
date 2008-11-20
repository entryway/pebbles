class UpdateListOrderForSizesInProductOptionSelections < ActiveRecord::Migration
  def self.up
    execute "Update product_option_selections Set list_order = 1 where name = 'Small'"
    execute "Update product_option_selections Set list_order = 2 where name = 'Medium'"
    execute "Update product_option_selections Set list_order = 3 where name = 'Large'"
    execute "Update product_option_selections Set list_order = 4 where name = 'X-Large'"
    execute "Update product_option_selections Set list_order = 1 where name = '6-12 M'"
    execute "Update product_option_selections Set list_order = 2 where name = '12-18 M'"
    execute "Update product_option_selections Set list_order = 3 where name = '18-24 M'"

  end

  def self.down
  end
end
