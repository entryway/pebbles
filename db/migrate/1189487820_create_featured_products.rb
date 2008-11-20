class CreateFeaturedProducts < ActiveRecord::Migration
  def self.up
    create_table "featured_products" do |t|
      foreign_key :product_id
    end
  end

  def self.down
  end
end
