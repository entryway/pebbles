class AddFeaturedColumn < ActiveRecord::Migration
  def self.up
    add_column :products, :is_featured, :boolean
  end

  def self.down
    remove_column :products, :is_featured
  end
end
