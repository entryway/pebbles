class RenameProductSelectionType < ActiveRecord::Migration
  def self.up
    rename_column :product_options, :selection_type_id, :selection_type
  end

  def self.down
    rename_column :product_options, :selection_type, :selection_type_id
  end
end