class Admin::VariantLargeImagesController < ApplicationController
  layout "admin"
  require_role "admin"

  def create
    variant_image = VariantImage.find(params[:variant_image_id])
    variant_image.create_variant_large_image(params[:variant_large_image])
    render :partial => "admin/products/variant_large_image",
           :locals => { :large_image => variant_image.variant_large_image,
                        :variant_image => variant_image }
  end

  def destroy
    variant_image = VariantImage.find(params[:variant_image_id])
    large_image = VariantLargeImage.find(params[:id])
    large_image.destroy
    render :partial => "admin/products/variant_large_image",
           :locals => { :large_image => variant_image.build_variant_large_image,
                        :variant_image => variant_image }
  end

end
