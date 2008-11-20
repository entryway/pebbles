class OptionSelectionsPrice < ActiveRecord::Migration
  def self.up
    remove_column :option_selections, :price_adjustment_as_cents
    add_column :option_selections, :price_adjustment,     :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :option_selections, :price_adjustment
    add_column :option_selections, :price_adjustment_as_cents,   :integer, :default => 0
  end
end
