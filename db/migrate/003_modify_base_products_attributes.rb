class ModifyBaseProductsAttributes < ActiveRecord::Migration
  def self.up
    remove_column :products, :title
    remove_column :products, :subtitle
    remove_column :products, :description
    add_column :products, :name, :string, :limit => 255
    add_column :products, :subname, :string, :limit => 50
    add_column :products, :short_description, :text
    add_column :products, :price_as_cents, :integer
    add_column :products, :weight, :decimal, :precision => 8, :scale => 2
    add_column :products, :admin_notes, :text
  end

  def self.down
    add_column :products, :title, :string
    add_column :products, :subtitle, :string
    add_column :products, :description, :text
    remove_column :products, :name
    remove_column :products, :second_name
    remove_column :products, :short_description
    remove_column :products, :price_as_cents
    remove_column :products, :weight, :decimal 
    remove_column :products, :admin_notes, :text 
  end
end


