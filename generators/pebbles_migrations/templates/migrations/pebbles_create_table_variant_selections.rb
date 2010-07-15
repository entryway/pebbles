class PebblesCreateTableVariantSelections < ActiveRecord::Migration
  def self.up
    create_table :variant_selections do |t|
      t.integer :variant_id, :product_option_selection_id
      t.timestamps
    end
  end

  def self.down
    drop_table :variant_selections
  end
end
