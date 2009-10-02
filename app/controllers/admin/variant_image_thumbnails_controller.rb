class Admin::VariantImageThumbnailsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    image = VariantImage.find(params[:variant_image_id])
    image.create_variant_image_thumbnail(params[:variant_image_thumbnail]) 
    render "admin/products/variant_thumbnail", :thumbnail => variant_image.variant_image_thumbnail,
                                               :variant_image => variant_image
  end
  
  def destroy
    thumbnail = VariantImageThumbnail.find(params[:id])
    thumbnail.destroy
    render "admin/products/variant_thumbnail", :thumbnail => variant_image.build_variant_image_thumbnail,
                                               :variant_image => variant_image
  end
end
