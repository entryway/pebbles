class CreateOrderItemSelections < ActiveRecord::Migration
  def self.up
    create_table :order_item_selections do |t| 
      t.column "order_item_id",             :integer
      t.column "option_selection_id",       :integer
      t.column "product_option_id",         :integer
      t.column 'product_option_name',       :string,    :limit => 50
      t.column 'option_selection_name',     :string,    :limit => 50
      t.column 'price_adjustment_as_cents', :integer,   :default => 0
      t.column 'weight_adjustment',         :decimal,   :precision => 8, :scale => 2, :default => 0.0
    end
  end

  def self.down
    drop_table :order_item_selections
  end
end
