class AddVariantImageTable < ActiveRecord::Migration
  def self.up
    create_table "variant_images", :force => true do |t|
      t.string  "filename"
    end
  end

  def self.down
    drop_table "variant_images"
  end
end
