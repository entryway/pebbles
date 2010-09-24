class AddCategoryIconHoversTable < ActiveRecord::Migration
  def self.up
    create_table "category_icon_hovers", :force => true do |t|
      t.string  "filename"
      t.integer "category_icon_id"
    end
  end

  def self.down
    drop_table "category_icons"
  end
end