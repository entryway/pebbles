class Admin::ProductImageThumbnailsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    image = ProductImage.find(params[:product_image_id])
    product = image.product
    if params[:product_image_thumbnail][:filename].present?
      image.create_product_image_thumbnail(params[:product_image_thumbnail])
    end 
    render :partial => 'admin/products/images/images', 
           :locals => { :product => product }
  end
  
  def destroy
    thumbnail = ProductImageThumbnail.find(params[:id])
    product = thumbnail.product
    thumbnail.destroy
    render :partial => '/admin/products/images/images', 
           :locals => { :product => product }
  end
end
