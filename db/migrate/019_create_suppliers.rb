class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |table|
      table.column :name,                  :string, :limit => 50, :null => false
      table.column :description,           :text
      table.column :active,                :boolean
      table.column :drop_ship,             :boolean 
      table.column :shipping_as_cents,     :integer 
    end
   end

  def self.down
    drop_table :suppliers 
  end
end 