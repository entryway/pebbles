class VariantsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  def show
    product = Product.find(params[:product_id])
    variant = product.find_variant_by_selection_ids(params[:selection_ids].split(',').map{|s| s.to_i})
    render :text => number_to_currency(variant.price)
  end
  
end
