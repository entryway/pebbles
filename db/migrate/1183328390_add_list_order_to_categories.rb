class AddListOrderToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :position, :integer, :null => false
  end

  def self.down

    remove_column :categories, :position
  end
end
