class Admin::CategoryImagesController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    category = Category.find(params[:category_id])
    category.category_images.create(params[:category_image])
    category = Category.find(params[:category_id])
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
