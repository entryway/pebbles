class CreateProductOptions < ActiveRecord::Migration
  def self.up
    create_table :product_options do |t|
      t.column :name,                  :string, :limit => 50, :null => false
      t.column :selection_type_id,     :integer
      t.column :option_selection_id,   :integer
      t.column :description,           :text  
    end
  end

  def self.down
    drop_table :product_options
  end
end