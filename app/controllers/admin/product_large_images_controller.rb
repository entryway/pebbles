class Admin::ProductLargeImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    image = ProductImage.find(params[:product_image_id])
    product = image.product
    if params[:product_large_image][:filename].present?
      image.create_product_large_image(params[:product_large_image]) 
    end
    render :partial => '/admin/products/images/images', 
           :locals => { :product => product }
  end
  
  def destroy
    large_image = ProductLargeImage.find(params[:id])
    product = large_image.product
    large_image.destroy
    render :partial => '/admin/products/images/images', 
           :locals => { :product => product }
  end
end
