class Admin::CategoryImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    category = Category.find(params[:category_id])
    category_image = CategoryImage.new(params[:category_image])
    category.category_images << category_image
    render :partial => '/admin/categories/image_list', 
           :locals => { :category => category }
  end
  
  def destroy
    category = Category.find(params[:category_id])
    category_image = CategoryImage.find(params[:id])
    category_image.destroy
    render :partial => '/admin/categories/image_list', 
           :locals => { :category => category }
  end   

end
