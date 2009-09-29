class Admin::ProductLargeImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    image = ProductImage.find(params[:product_image_id])
    product = image.product
    image.create_product_large_image(params[:product_large_image]) 
    render :partial => '/admin/products/images/image_list', 
           :locals => { :product => product }
  end
  
  def destroy
    large_image = ProductLargeImage.find(params[:id])
    product = large_image.product
    large_image.destroy
    render :partial => '/admin/products/images/image_list', 
           :locals => { :product => product }
  end
end
