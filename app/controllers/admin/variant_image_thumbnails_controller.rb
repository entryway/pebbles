class Admin::VariantImageThumbnailsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    variant_image = VariantImage.find(params[:variant_image_id])
    variant_image.create_variant_image_thumbnail(params[:variant_image_thumbnail]) 
    render :partial => "admin/products/variant_thumbnail", 
           :locals => { :thumbnail => variant_image.variant_image_thumbnail,
                                               :variant_image => variant_image }
  end
  
  def destroy
    variant_image = VariantImage.find(params[:variant_image_id])
    thumbnail = VariantImageThumbnail.find(params[:id])
    thumbnail.destroy
    render :partial => "admin/products/variant_thumbnail",
           :locals => { :thumbnail => variant_image.build_variant_image_thumbnail,
                                               :variant_image => variant_image}
  end
end
