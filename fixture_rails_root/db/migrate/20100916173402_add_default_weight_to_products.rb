class AddDefaultWeightToProducts < ActiveRecord::Migration
  def self.up
    change_column(:products, :weight, :decimal, :precision => 8, :scale => 2, 
      :default => 0.0)
  end

  def self.down
    change_column(:products, :weight, :decimal, :precision => 8, :scale => 2)
  end
end
