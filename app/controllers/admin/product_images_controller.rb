class Admin::ProductImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create
    product = Product.find(params[:product_id])
    if params[:product_image][:filename].present? 
      product.product_images.create(params[:product_image])
      product = Product.find(params[:product_id])
    end
    render :partial => 'admin/products/images/images', 
           :locals => { :product => product }
  end
  
  def update
    product = Product.find(params[:product_id])
    product_image = ProductImage.find(params[:id])
    if params[:product_image][:filename].present? 
      product_image.update_attributes(params[:product_image])
    end
    render :partial => 'admin/products/images/images', 
           :locals => { :product => product }
  end
    
  
  def destroy
    product = Product.find(params[:product_id])
    product_image = ProductImage.find(params[:id])
    product_image.destroy
    render :partial => 'admin/products/images/images', 
           :locals => { :product => product }
  end   

end
