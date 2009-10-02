class Admin::VariantImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def new
    variant_image = VariantImage.new
    variant_image.build_variant_large_image
    variant_image.build_variant_image_thumbnail
    render :partial => "admin/products/variant_image", :locals => { :variant_image => variant_image }
  end
  
  def show
    variant_image = VariantImage.find(params[:id])
    variant_image.build_variant_large_image unless variant_image.variant_large_image
    variant_image.build_variant_image_thumbnail unless variant_image.variant_image_thumbnail
    render :partial => "admin/products/variant_image", :locals => { :variant_image => variant_image }
  end
  
  def create 
    variants = Variant.find(params[:variant_ids].split(',').map{|s| s.to_i})
    product = variants.first.product
    variant_image = VariantImage.create(params[:variant_image])
    variant_image.variants << variants
    variant_image.build_variant_large_image
    variant_image.build_variant_image_thumbnail
    render :partial => "admin/products/variants", :locals => { :variants => variants, :product => product, 
                                                               :variant_image => variant_image}
  end
  
  def destroy
    variant_image = VariantImage.find(params[:id])
    product = variant_image.product
    variants = product.variants
    variant_image.destroy
    render :partial => "admin/products/variants", :locals => { :variants => variants, :product => product, 
                                                               :variant_image => VariantImage.new}
    
  end   

end