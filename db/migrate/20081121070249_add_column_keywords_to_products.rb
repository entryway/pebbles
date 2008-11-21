class AddColumnKeywordsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :keywords, :text
    add_column :products, :description, :text
    add_column :products, :title, :string, :limit => 255
  end

  def self.down
    remove_column :products, :title
    remove_column :products, :keywords
    remove_column :products, :descritpion
  end
end
