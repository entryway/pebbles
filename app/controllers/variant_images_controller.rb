class VariantImagesController < ApplicationController
  
  def index
    product = Product.find(params[:product_id])
    render :partial => 'products/variant_images', :locals => { :product => product }
  end 
   
  def show
    variant_image = VariantImage.find(params[:id])
    render :partial => 'products/product_image', :locals => { :image => variant_image }
  end
  
end
