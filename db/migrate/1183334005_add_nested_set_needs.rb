class AddNestedSetNeeds < ActiveRecord::Migration
  def self.up
    drop_table :categories
  
    create_table :categories do |table|
      integer :parent_id
      string :name
      integer :lft
      integer :rgt
      integer :position
    end
    
    product_category = Category.new(:name => "products", :position => 0)
    product_category.save
  end

  def self.down
    drop_table :categories
  end
end
