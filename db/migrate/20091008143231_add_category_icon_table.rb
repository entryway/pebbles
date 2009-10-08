class AddCategoryIconTable < ActiveRecord::Migration
  def self.up
    create_table "category_icons", :force => true do |t|
      t.string  "filename"
      t.integer "category_id"
    end
  end

  def self.down
    drop_table "category_icons"
  end
end
