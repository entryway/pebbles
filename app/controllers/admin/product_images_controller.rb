class Admin::ProductImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    product = Product.find(params[:product_id])
    product_image = ProductImage.new(params[:product_image])
    product.product_images << product_image
    render :partial => '/admin/products/images/image_list', 
           :locals => { :product => product }
  end
  
  def update
    product = Product.find(params[:product_id])
    product_image = ProductImage.find(params[:id])
    product_image.update_attributes(params[:product_image])
    render :partial => '/admin/products/images/image_list', 
           :locals => { :product => product }
  end
    
  
  def destroy
    product = Product.find(params[:product_id])
    product_image = ProductImage.find(params[:id])
    product_image.destroy
    render :partial => '/admin/products/images/image_list', 
           :locals => { :product => product }
  end   

end
