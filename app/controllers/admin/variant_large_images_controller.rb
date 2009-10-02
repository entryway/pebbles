class Admin::VariantLargeImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    image = VariantImage.find(params[:variant_image_id])
    image.create_variant_large_image(params[:variant_large_image]) 
    render "admin/products/variant_thumbnail", :thumbnail => variant_image.variant_large_image,
                                               :variant_image => variant_image
  end
  
  def destroy
    large_image = VariantLargeImage.find(params[:id])
    large_image.destroy
    render "admin/products/variant_thumbnail", :large_image => variant_image.build_variant_large_image,
                                               :variant_image => variant_image
  end
  
end
