class Admin::VariantsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def update
    variant = Variant.find(params[:id])
    variant.variant_image_id = nil
    variant.save!
    product = variant.product
    variants = product.variants
    render :partial => "admin/products/variants", :locals => { :variants => variants, :product => product, 
                                                               :variant_image => VariantImage.new}
  end   

end