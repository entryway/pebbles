class PebblesAddVariantImageThumbnailAndLargeTables < ActiveRecord::Migration
  def self.up
    create_table "variant_image_thumbnails", :force => true do |t|
      t.integer "variant_image_id"
      t.string  "filename"
    end

   create_table "variant_large_images", :force => true do |t|
     t.integer "variant_image_id"
     t.string  "filename"
    end
  end

  def self.down
    drop_table "variant_image_thumbnails"
    drop_table "variant_large_images"
  end
end
