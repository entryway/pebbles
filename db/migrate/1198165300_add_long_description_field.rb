class AddLongDescriptionField < ActiveRecord::Migration
  def self.up
    add_column :products, :long_description, :text
  end

  def self.down
  end
end
