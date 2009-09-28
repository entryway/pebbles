class VariantsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  def show
    product = Product.find(params[:product_id])
    variant = product.find_variant_by_selection_ids(params[:selection_ids].split(',').map{|s| s.to_i})
    render :json => { :price => number_to_currency(variant.price), 
                      :out_of_stock => variant.out_of_stock_check }
  end
  
end
