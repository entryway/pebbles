class ChangeColumnPositionInCategories < ActiveRecord::Migration
  def self.up
    change_column :categories, :position, :integer, :default => 99
  end

  def self.down
  end
end
