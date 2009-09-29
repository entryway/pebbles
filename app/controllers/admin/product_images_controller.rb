
module Admin

class ProductImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    product = Product.find(params[:product_id])
    product_image = ProductImage.new(params[:product_image])
    product.product_images << product_image
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
    
    
  
  # add an image to a product
   def add_product_image
     image = ProductImage.new(params[:product_image])
     product = Product.find(params[:id])
     product.product_images << image
   
     responds_to_parent do
       render :update do |page| 
         page[:image_list].replace_html :partial => '/admin/products/images/image_list', 
                                        :locals => { :product => product }
       end
     end
   end  
 
   # add an image thumbnail to a product
   # todo: add to RESTful ProductImageThumbnailConroller
   def add_product_thumbnail
     image_thumbnail = ProductImageThumbnail.new(params[:product_thumbnail])
     product = Product.find(params[:id])
     # only add thumbs to first image
     unless product.product_images[0].nil?
       product.product_images[0].thumbnails << image_thumbnail
     end
   
     responds_to_parent do
       render :update do |page| 
         page[:image_thumbnail_list].replace_html :partial => '/admin/products/images/image_thumbnail_list', 
                                        :locals => { :product => product }
       end
     end
   end
   
   # add a large image to a product
   def add_product_large_image
     image = ProductLargeImage.new(params[:product_large_image])
     product = Product.find(params[:id])
     product.product_large_images << image
   
     responds_to_parent do
       render :update do |page| 
         page[:image_large_list].replace_html :partial => '/admin/products/images/image_large_list', 
                                        :locals => { :product => product }
       end
     end
   end
   
   # remove an image from the product
   def remove_product_image
     @product = Product.find(params[:id])
     @image = ProductImage.find(params[:image_id])
     @product.product_images.delete(@image)  
   
     respond_to do |format|
       format.js { 
         render :partial => '/admin/products/images/image_list', 
                :locals => { :product => @product }
       }
     end
   end
 
   # remove an image from the product
   def remove_product_thumbnail
     @product = Product.find(params[:id])
     @thumb = ProductImageThumbnail.find(params[:image_id])
     unless @product.product_images[0].nil?
       @product.product_images[0].thumbnails.delete(@thumb)  
     end
    
     respond_to do |format|
       format.js { 
         render :partial => '/admin/products/images/image_thumbnail_list', 
                :locals => { :product => @product }
       }
     end   
   end
   
   # remove a large image from the product
   def remove_product_large_image
     @product = Product.find(params[:id])
     @image = ProductLargeImage.find(params[:image_id])
     @product.product_large_images.delete(@image)  
   
     respond_to do |format|
       format.js { 
         render :partial => '/admin/products/images/image_large_list', 
                :locals => { :product => @product }
       }
     end
   end
 
 end
end