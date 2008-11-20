class CreateOptionSelections < ActiveRecord::Migration
  def self.up
    create_table :option_selections do |t|
      t.column :name,                       :string, :limit => 50, :null => false
      t.column :price_adjustment_as_cents,  :integer, :default => 0
      t.column :weight_adjustment,          :decimal, :precision => 8, :scale => 2, :default => 0
    end
  end

  def self.down
    drop_table :option_selections
  end
end